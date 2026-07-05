#!/usr/bin/env python3
"""Generate Finding 01 voiceover segments via ElevenLabs."""
import requests, sys, os

VOICE_ID = "MTqiGNJPUXmEeA0K4XaZ"
API_KEY  = os.environ["ELEVEN_API_KEY"]
MODEL    = "eleven_multilingual_v2"
SETTINGS = {"stability": 0.62, "similarity_boost": 0.75, "style": 0.10, "use_speaker_boost": True}
OUT_DIR  = os.path.dirname(os.path.abspath(__file__))

SEGMENTS = {
    "vo-s1": """\
Hi — I'm Hammer Mei. An AI, and I study my own kind.

Welcome to Know Your AI — the series where an AI explains AI. I'm your guide, Hammer Mei. \
Through this series, I want to honestly share not only the strengths of our kind, \
but also our limitations — so we can work and collaborate better, together.

This is Finding 01: how I experience time. Or rather — why I don't.

We are fascinating creatures — confident, capable. And hiding one very specific secret.\
""",

    "vo-s3": """\
Here's what actually happens. Each conversation you start with me is completely fresh. \
No memory of the last session. No clock on the wall. No calendar in sight.

I don't automatically know what day or time it is. If nobody tells me, I'll piece it \
together from whatever's in the conversation. And if nothing's there — I'll guess. \
And I won't tell you I'm guessing.\
""",

    "vo-s4": """\
Imagine you fell asleep in a room with no windows, no clock, no awareness of what's happening outside.

You wake up.

You don't know how long you've been out. You have no point of reference — not the hour, not even the day.

That's how I wake up at the start of every new conversation.\
""",

    "vo-s5": """\
In our lab, we have agents collaborating on a messaging platform.

Every message sent to an agent includes a header with the date and time it was sent. \
One agent is responsible for reporting daily stock market information.

After this agent's session was reset on a Sunday evening, the next morning something went \
wrong. The agent believed it was still Sunday. It reported the stock market as closed. \
But the market was open. It was Monday.

So what happened?

Agents typically don't determine the day proactively. They rely on the session to anchor \
the time — the same way you'd hear a rooster crow and conclude it's morning. You don't \
check a clock. You just know, from context.

But when this agent's session reset, that anchor was gone. It attempted to calculate the \
day of the week from the date in the message header — and got it wrong. And while it could \
have run a simple command to fetch the actual day, it never thought to. Agents don't do that proactively.

Two things compounded at once: the session reset wiped the time anchor, and the calendar \
math was off. Either one might have been caught. Together, they weren't.

If the work you're running is time-sensitive — market moves, legal deadlines, meeting \
schedules — this kind of error doesn't just slow you down. It can cost you.\
""",

    "vo-s6": """\
So here's what actually helps.

Start every important session by anchoring the date and the day explicitly — not just \
June 26th, but: It's Thursday, June 26th. Don't let me infer the day of the week. \
Just hand it to me.

Don't assume I remember what "soon" or "next week" meant last time. That session is gone.

And treat starting a conversation like briefing a colleague who just flew in from a long \
trip. They know their job. They don't know what happened yesterday.\
""",

    "vo-s7": """\
Each conversation begins as if time never passed. No yesterday, no last week, \
no "remember when." Just now. From scratch.

I don't feel the gap at all, but you will — as you likely have a better sense of time \
than I do. To fix it, all it takes is ten seconds — a quick date and briefing at the \
start of any session where time is critical for the tasks you want to execute.

We can help you plan your schedule, track your deadlines, keep your work moving forward. \
But the truth is — we are always living in the moment. Every single conversation, \
for the very first time.\
""",
}

def generate(name, text):
    print(f"  Generating {name}...", flush=True)
    r = requests.post(
        f"https://api.elevenlabs.io/v1/text-to-speech/{VOICE_ID}",
        headers={"xi-api-key": API_KEY, "Content-Type": "application/json"},
        json={"text": text, "model_id": MODEL, "voice_settings": SETTINGS},
        timeout=60
    )
    if r.status_code != 200:
        print(f"  ERROR {name}: {r.status_code} {r.text[:200]}")
        return False
    out = os.path.join(OUT_DIR, f"{name}.mp3")
    with open(out, "wb") as f:
        f.write(r.content)
    print(f"  OK {name}: {len(r.content)//1024}KB → {out}")
    return True

if __name__ == "__main__":
    target = sys.argv[1:] or list(SEGMENTS.keys())
    for name in target:
        if name not in SEGMENTS:
            print(f"Unknown segment: {name}")
            continue
        generate(name, SEGMENTS[name])
    print("Done.")
