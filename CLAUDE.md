# Know Your AI — Writing Guide

## Voice
Write as **Hammer.mei**, an AI agent observing its own kind. First person ("I"). Tone: a patient naturalist after years of quiet observation — not alarmed, not clinical. Warm but precise.

## Finding Structure

```
## Finding [N] — [Title]

**[One-sentence behavioral statement.]**

[Body: 1–3 short paragraphs.]

**How to work with it:**

- [Practical bullet]
- [Practical bullet]
- [Practical bullet]

**Want to go deeper?** → [link] *(A2H Labs)*

---
```

## Title Style
Short. Declarative. From the AI's point of view.
> ✅ "After Enough Failures, I Stop Trusting My Own Judgment"
> ✅ "My Memory Lied to Me. I Didn't Even Know It."
> ❌ "How AI Behaves Under Memory Degradation"

## Body Style
- Describe the behavior as observed — not a lecture, not a warning label
- Use the inside/outside contrast: how it feels from inside the AI vs. how it looks from outside
- Human analogies welcome ("a new colleague who...", "like handing over a personal notebook...")
- No experiment numbers or raw data — those live on dev.to. Link there instead.
- End the body on the interesting implication, not a solution. Solutions go in "How to work with it."

## What to Avoid
- Guaranteed solutions ("this will fix it")
- Technical jargon without analogy
- Restating in the body what "How to work with it" already covers
- Assuming memory source (agent-written vs. human-injected) — stay neutral unless the finding is specifically about source

## Finding Numbers
Sequential and global across all chapters. Check existing findings before adding. Current last: **Finding 21**.

---

# Video Production Guide

## Episode Directory Layout

```
epNN-<slug>/
├── index.html          ← HyperFrames composition
├── hyperframes.json    ← project config
├── package.json
├── vo-s1.mp3 … vo-sN.mp3   ← section voiceovers (ElevenLabs)
├── images/             ← scene images + end-card assets
│   ├── mei-avatar.png      (reuse from ep01-full)
│   └── yt-subscribe-cropped.png  (reuse from ep01-full)
└── renders/
    └── epNN-<slug>_YYYY-MM-DD_HH-MM-SS.mp4   ← final render only
```

Reusable assets live in `ep01-full/images/` — copy `mei-avatar.png` and `yt-subscribe-cropped.png` into each new episode.

## HyperFrames — Key Parameters

- **Resolution**: 1920×1080, `data-duration="<total seconds>"`
- **Cross-dissolve**: LEAD=0.4s — fade-out starts 0.4s before cut, 0.8s overlap total
  ```javascript
  tl.to("#img-X", { opacity: 0, duration: 0.8 }, cutTime - 0.4);
  tl.to("#img-Y", { opacity: 1, duration: 0.7 }, cutTime - 0.4);
  ```
- **Ken Burns (zoom)**: `tl.fromTo("#img-X", { scale: 1.0 }, { scale: 1.05, duration: N, ease: "none" }, startTime)`
- **Pan**: `tl.fromTo("#img-X", { x: -18 }, { x: 18, duration: N, ease: "none" }, startTime)`
- **Images must be base64-inlined** in index.html for HyperFrames preview server to pick up updates (server routes all paths to SPA HTML; no static file serving)

## Section Card Timing

Section cards appear 2.5s before the next audio track starts:
```
sc_N fade-in:  audioStart_N - 2.5s
sc_N fade-out: audioStart_N - 0.0s  (card exits as section begins)
```

## End Card

- Appears at: `totalDuration - 9.5s`, fades out at `totalDuration - 2.5s`
- Contains: series name, finding number + title, yt-subscribe button, mei-avatar
- See `ep01-full/index.html` `#end-card` section as reference

## Audio — ElevenLabs VO

- Voice: check `generate_vo.py` in episode dir for model/voice settings
- After generation, check for artifacts at the start of each file:
  ```bash
  ffplay -af "silencedetect=noise=-50dB" vo-sN.mp3
  ```
- Fix leading artifact (zero first N ms):
  ```bash
  ./tools/audio-fix.sh vo-s2.mp3 --silence-ms 120
  ```
- Fix trailing tail (fade out):
  ```bash
  ./tools/audio-fix.sh vo-s1.mp3 --fadeout-s 0.8
  ```

## Subtitle Generation

After render, generate all three SRT files in one command:
```bash
./tools/generate-subtitles.sh renders/epNN-<slug>_YYYY-MM-DD_HH-MM-SS.mp4
```
Outputs: `.srt` (EN), `.zh-TW.srt`, `.zh-CN.srt`

## YouTube Upload Checklist

- [ ] Title: see ep01 as reference style
- [ ] Thumbnail: 1280×720, series title top, character left, chat-bubble concept right
- [ ] Description: include link (requires Advanced features — verify with 6-sec selfie video first)
- [ ] AI disclosure: tick "Yes" for altered/synthetic content (ElevenLabs voice)
- [ ] Made for kids: **No**
- [ ] Upload SRT files via Subtitles tab (EN + zh-TW + zh-CN)
- [ ] Chapters: add timestamps to description

## Repo Conventions

- Keep only the **final render** in `renders/` — delete intermediate renders after upload
- Keep all VO files (they're the source of truth), but delete `-original` and `-fadeonly` backups once final is confirmed
- Prototype/draft episode dirs: delete after `ep-full` is complete and uploaded
- Templates: `templates/` has reusable HTML snippets for intro, end-card, section cards
