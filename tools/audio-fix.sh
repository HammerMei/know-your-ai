#!/usr/bin/env bash
# audio-fix.sh — Fix common VO artifacts from ElevenLabs generation
#
# Usage: ./tools/audio-fix.sh <input.mp3> [options]
#
# Options:
#   --silence-ms N    Zero out first N milliseconds (default: 0, skip)
#   --fadeout-s  N    Fade out last N seconds (default: 0, skip)
#   --output     PATH Output path (default: <input>_fixed.mp3)
#
# Examples:
#   ./tools/audio-fix.sh vo-s2.mp3 --silence-ms 120
#   ./tools/audio-fix.sh vo-s1.mp3 --fadeout-s 0.8
#   ./tools/audio-fix.sh vo-s2.mp3 --silence-ms 120 --fadeout-s 0.5

set -euo pipefail

INPUT="${1:-}"
if [[ -z "$INPUT" ]]; then
  echo "Usage: $0 <input.mp3> [--silence-ms N] [--fadeout-s N] [--output PATH]" >&2
  exit 1
fi

SILENCE_MS=0
FADEOUT_S=0
OUTPUT="${INPUT%.mp3}_fixed.mp3"

shift
while [[ $# -gt 0 ]]; do
  case "$1" in
    --silence-ms) SILENCE_MS="$2"; shift 2 ;;
    --fadeout-s)  FADEOUT_S="$2";  shift 2 ;;
    --output)     OUTPUT="$2";     shift 2 ;;
    *) echo "Unknown option: $1" >&2; exit 1 ;;
  esac
done

# Get duration for fadeout calculation
DURATION=$(ffprobe -v quiet -show_entries format=duration -of csv=p=0 "$INPUT")

FILTERS=()

if [[ "$SILENCE_MS" -gt 0 ]]; then
  SILENCE_S=$(echo "scale=6; $SILENCE_MS / 1000" | bc)
  FILTERS+=("volume=enable='lt(t,${SILENCE_S})':volume=0")
  echo "▶ Zeroing first ${SILENCE_MS}ms"
fi

if (( $(echo "$FADEOUT_S > 0" | bc -l) )); then
  FADE_START=$(echo "scale=3; $DURATION - $FADEOUT_S" | bc)
  FILTERS+=("afade=t=out:st=${FADE_START}:d=${FADEOUT_S}")
  echo "▶ Fade out last ${FADEOUT_S}s (starts at ${FADE_START}s)"
fi

if [[ ${#FILTERS[@]} -eq 0 ]]; then
  echo "No filters specified. Use --silence-ms or --fadeout-s." >&2
  exit 1
fi

FILTER_STR=$(IFS=,; echo "${FILTERS[*]}")

ffmpeg -i "$INPUT" -af "$FILTER_STR" -y "$OUTPUT"
echo "✅ Saved to: $OUTPUT"
