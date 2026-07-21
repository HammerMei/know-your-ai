# Know Your AI — Episode Production Workflow

Step-by-step runbook for creating each episode. Follow in order.
Reference `CLAUDE.md` for HyperFrames parameters and technical details.

---

## Phase 1 — Pre-Production

### 1. Write the Finding

- Draft in `docs/chN-<topic>.md` using the Finding structure in `CLAUDE.md`
- Voice: Hammer Mei, first person, patient naturalist
- Required sections: behavioral statement, body (1–3 paragraphs), Human Parallel, Field Note (if applicable), How to work with it
- Check Finding number — must be sequential, no gaps

### 2. Generate Scene Images

- Write image prompts for each section (save as `epNN-<slug>/image-prompts.md` during drafting, delete before commit)
- Generate via Midjourney or similar
- Name convention: `scene1.png`, `scene2a.png`, `scene2b.png`, etc.
- Place in `epNN-<slug>/images/`
- Reuse from `ep01-full/images/`: `mei-avatar.png`, `yt-subscribe-cropped.png`

### 3. Generate Voiceover

Copy `ep01-full/generate_vo.py` into the new episode dir and update the script text.

**Voice settings** (keep consistent across all episodes):
```python
VOICE_ID = "MTqiGNJPUXmEeA0K4XaZ"
MODEL    = "eleven_multilingual_v2"
SETTINGS = {"stability": 0.62, "similarity_boost": 0.75, "style": 0.10, "use_speaker_boost": True}
```

Get API key from KeePass vault (entry: `ElevenLabs API Key`):
```bash
keepassxc-cli show -s --no-password --show-protected \
  -k ~/.kpx-keys/assistant.key \
  ~/.tamago/hammer.mei-profile/secrets/assistant.kdbx \
  "ElevenLabs API Key"
```

Run:
```bash
ELEVENLABS_API_KEY=<key> python3 generate_vo.py
```

### 4. Fix Audio Artifacts

Check each VO file for leading artifacts (common with ElevenLabs):
```bash
ffplay vo-sN.mp3   # listen for clicks/pops at start
```

Fix leading artifact (zero first N ms):
```bash
../../tools/audio-fix.sh vo-s2.mp3 --silence-ms 120 --output vo-s2-fixed.mp3
mv vo-s2-fixed.mp3 vo-s2.mp3
```

Fix trailing tail (fade out last N seconds):
```bash
../../tools/audio-fix.sh vo-s1.mp3 --fadeout-s 0.8 --output vo-s1-fixed.mp3
mv vo-s1-fixed.mp3 vo-s1.mp3
```

---

## Phase 2 — Composition

### 5. Set Up HyperFrames Project

```bash
cp ep01-full/package.json epNN-<slug>/
cd epNN-<slug> && npm install
```

Create `index.html` based on `ep01-full/index.html` as reference. Key parameters:
- Resolution: `1920×1080`
- Set `data-duration="<total seconds>"` once you know the total length
- Audio tracks: one `<audio>` element per section VO
- Images: **must be base64-inlined** (HyperFrames server doesn't serve static files)

To inline an image:
```bash
python3 -c "
import base64, sys
data = open('images/scene1.png','rb').read()
b64 = base64.b64encode(data).decode()
ext = 'png'
print(f'data:image/{ext};base64,{b64[:80]}...')
"
```

### 6. Build the Timeline

**Section card timing** (appears 2.5s before next section audio starts):
```javascript
// sc fades in at audioStart - 2.5, fades out at audioStart
tl.to("#sc1", { opacity: 1, duration: 0.5 }, audioStart - 2.5);
tl.to("#sc1", { opacity: 0, duration: 0.5 }, audioStart - 0.2);
```

**Cross-dissolve between images** (LEAD = 0.4s):
```javascript
tl.to("#img-current", { opacity: 0, duration: 0.8 }, cutTime - 0.4);
tl.to("#img-next",    { opacity: 1, duration: 0.7 }, cutTime - 0.4);
```

**Ken Burns (zoom):**
```javascript
tl.fromTo("#img-X", { scale: 1.0 }, { scale: 1.05, duration: N, ease: "none" }, startTime);
```

**Pan:**
```javascript
tl.fromTo("#img-X", { x: -18 }, { x: 18, duration: N, ease: "none" }, startTime);
```

**End card** (appears 9.5s before end, fades at 2.5s before end):
```javascript
tl.to("#end-card", { opacity: 1, duration: 1.2 }, totalDuration - 9.5);
tl.to("#end-card", { opacity: 0, duration: 1.5 }, totalDuration - 2.5);
```

### 7. Preview

```bash
cd epNN-<slug>
npx hyperframes preview   # or: npm start
```

Open in browser, scrub through timeline, check all transitions.

> ⚠️ If images aren't updating in preview: the server caches images. Base64-inline them directly in `index.html`.

---

## Phase 3 — Render & Post-Production

### 8. Render

```bash
npx hyperframes render
```

Output lands in `renders/epNN-<slug>_YYYY-MM-DD_HH-MM-SS.mp4`.

After confirming the final render, delete all intermediate renders.

### 9. Generate Subtitles

```bash
../../tools/generate-subtitles.sh renders/epNN-<slug>_YYYY-MM-DD_HH-MM-SS.mp4
```

Outputs three files in `renders/`:
- `.srt` — English
- `.zh-TW.srt` — Traditional Chinese
- `.zh-CN.srt` — Simplified Chinese

Review all three for accuracy, especially:
- Character name: `Hammer Mei` → `鐵鎚老妹` (TW) / `铁锤老妹` (CN)
- Series name: `Know Your AI` → `了解你的AI`
- Unnatural literal translations (e.g. "I have a confession to make" → `我有件事想坦白` ✅)

---

## Phase 4 — YouTube Upload

### 10. Create Thumbnail

- Size: 1280×720px
- Style reference: `ep01` thumbnail — series title top in purple gradient, character left, chat-bubble concept right
- Tools: Canva (YouTube Banner template) or Figma

### 11. Upload Video

Go to [studio.youtube.com](https://studio.youtube.com) → Create → Upload video.

**Details tab:**
- [ ] Title: short, declarative, from AI's point of view
- [ ] Description: see ep01 as reference (include guide link, chapters, AI disclosure)
- [ ] Thumbnail: upload custom thumbnail
- [ ] AI disclosure: tick **"Yes"** (ElevenLabs voice = synthetic content)
- [ ] Made for kids: **No**
- [ ] Add chapters to description (timestamps)

**Subtitles tab:**
- [ ] Upload `.srt` → English
- [ ] Upload `.zh-TW.srt` → Chinese (Traditional)
- [ ] Upload `.zh-CN.srt` → Chinese (Simplified)

> ⚠️ External links in descriptions require YouTube Advanced features.
> Verify via: Studio → Settings → Channel → Feature eligibility → Advanced features → 6-second selfie video.

### 12. Publish

Set visibility → **Public** (or Unlisted to review first).

---

## Phase 5 — Content Update

### 13. Update the Guide

Update the corresponding `docs/chN-<topic>.md`:
- Sync Finding title with video title
- Add/refine Human Parallel if video analogy is better
- Add Field Note if a real incident was covered in video
- Add link to video: `[Watch Finding NN →](https://youtube.com/...)`

### 14. Commit & Push

```bash
git add epNN-<slug>/ docs/ && git commit -m "Add epNN: <finding title>"
git push origin main
```

GitHub Actions auto-deploys to [guide.a2hlabs.com](https://guide.a2hlabs.com) on push to `main`.

---

## Quick Reference — File Checklist Before Commit

Keep in git ✅ | Exclude from git ❌

| File | Keep? |
|------|-------|
| `index.html` | ✅ |
| `images/*.png` | ✅ |
| `vo-sN.mp3` | ✅ (source VO) |
| `transcript-sN.json` | ✅ (timing reference) |
| `generate_vo.py` | ✅ |
| `hyperframes.json`, `package.json`, `meta.json` | ✅ |
| `renders/*.mp4` | ❌ (gitignored) |
| `renders/*.srt` | ✅ |
| `renders/*.wav` | ❌ (gitignored) |
| `image-prompts.md` | ❌ (delete before commit) |
| `.thumbnails/`, `.waveform-cache/`, `.hyperframes/` | ❌ (gitignored) |
| Intermediate VO backups (`-original`, `-fadeonly`) | ❌ (delete after final confirmed) |
