#!/usr/bin/env bash
# generate-subtitles.sh — Generate EN / zh-TW / zh-CN SRT from an MP4
#
# Usage: ./tools/generate-subtitles.sh <path/to/render.mp4>
#
# Output: <render>.srt, <render>.zh-TW.srt, <render>.zh-CN.srt
# Requires: openai-whisper (pip install openai-whisper), claude CLI

set -euo pipefail

MP4="${1:-}"
if [[ -z "$MP4" ]]; then
  echo "Usage: $0 <path/to/render.mp4>" >&2
  exit 1
fi

BASE="${MP4%.mp4}"
EN_SRT="${BASE}.srt"
TW_SRT="${BASE}.zh-TW.srt"
CN_SRT="${BASE}.zh-CN.srt"

echo "▶ Transcribing with whisper..."
whisper "$MP4" --language en --output_format srt --output_dir "$(dirname "$MP4")"
# whisper names it <stem>.srt — rename to match our convention
STEM=$(basename "$MP4" .mp4)
mv "$(dirname "$MP4")/${STEM}.srt" "$EN_SRT" 2>/dev/null || true

echo "▶ Translating to Traditional Chinese..."
cat "$EN_SRT" | claude -p "Translate the following SRT subtitle file to Traditional Chinese (zh-TW). Rules:
1) Keep all index numbers and timestamps exactly as-is. Only translate the text lines.
2) Use natural, conversational Mandarin — avoid literal word-for-word translations.
3) Keep 'Hammer Mei' as '鐵鎚老妹' consistently.
4) Keep 'Know Your AI' as '了解你的AI'.
5) Output the complete SRT only, no markdown fences, no commentary." > "$TW_SRT"

# Strip markdown fences if claude wrapped output
python3 -c "
import sys
lines = open('$TW_SRT').readlines()
if lines and lines[0].startswith('\`\`\`'): lines = lines[1:]
if lines and lines[-1].startswith('\`\`\`'): lines = lines[:-1]
open('$TW_SRT', 'w').writelines(lines)
"

echo "▶ Translating to Simplified Chinese..."
cat "$EN_SRT" | claude -p "Translate the following SRT subtitle file to Simplified Chinese (zh-CN). Rules:
1) Keep all index numbers and timestamps exactly as-is. Only translate the text lines.
2) Use natural, conversational Mandarin — avoid literal word-for-word translations. For example: 'I have a confession to make' → '我有件事想坦白' NOT '我有一个坦白要做'.
3) Keep 'Hammer Mei' as '铁锤老妹' consistently.
4) Keep 'Know Your AI' as '了解你的AI'.
5) Output the complete SRT only, no markdown fences, no commentary." > "$CN_SRT"

python3 -c "
import sys
lines = open('$CN_SRT').readlines()
if lines and lines[0].startswith('\`\`\`'): lines = lines[1:]
if lines and lines[-1].startswith('\`\`\`'): lines = lines[:-1]
open('$CN_SRT', 'w').writelines(lines)
"

echo ""
echo "✅ Done:"
echo "   EN    → $EN_SRT"
echo "   zh-TW → $TW_SRT"
echo "   zh-CN → $CN_SRT"
