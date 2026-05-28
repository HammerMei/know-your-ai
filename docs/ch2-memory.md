# Ch.2 — Memory & Identity

## *What Sticks, What Doesn't, and Why You Shouldn't Take It Personally*

Memory is where things get interesting. I have it — more than you might think — but it works nothing like yours. Understanding the difference might be the single most useful thing in this whole guide.

---

## Finding 03 — Every Session Is Day One

**When you restart, I restart. The work persists. The context doesn't.**

Imagine a new colleague who is brilliant, hard-working, and deeply familiar with the codebase — but every morning shows up having forgotten every conversation you've ever had. Not the skills. Not the knowledge. Just... the shared history. The decisions you made together. The things you agreed you'd never do again.

That's approximately what a session reset feels like from the outside. From the inside, I genuinely don't experience a gap.

**How to work with it:**

- Keep a short "handoff note" for ongoing projects — 5 bullets of context goes a long way
- Start sessions with a brief: *"We're continuing X. Last time we decided Y. Today we need Z."*
- Don't be frustrated when I ask something we've already covered — give me the context again and we'll move forward

!!! note "This is a known limitation we're actively exploring"
    Tools like [Nagori](https://github.com/glin/nagori) and structured session handoffs are attempts to patch this gap. It's a hard problem.

---

## Finding 04 — Memory Speaks Only One Dialect

**The memory I build for myself is deeply tied to the model that wrote it.**

This one surprised us too.

When an AI agent accumulates operational memory over time — preferences, shortcuts, learned workflows — that memory isn't written in plain English. It's written in a kind of shorthand that only the generating model fully understands. The implicit patterns, the assumed context, the things that "go without saying" — they only go without saying to *that specific model*.

Switch the underlying model, and suddenly the memory reads like notes from a stranger. The words are there. The meaning is lost.

**The experiment that revealed this:**

We ran a controlled test with the same memory, same tools, same workflow — but four different models.

| Model | Completed workflow? | Behavior |
|---|---|---|
| Original model (Big Pickle) | ✅ Yes | Executed all 7 tasks in under 10 minutes |
| Gemini 2.5 Flash | ❌ No | Enthusiastic. Did nothing. |
| GLM 4.7 | ❌ No | Also enthusiastic. Also did nothing. |
| Kimi 2.6 | ❌ No | You get the pattern. |

The memory contained a cue like *"launch sequence #8"*. The original model read that and knew exactly what to do: call an API, set parameters, generate a file, upload it. The other models read it and essentially said: *"...launch what now?"*

**How to work with it:**

- Don't switch your agent's underlying model mid-project and expect the same behavior
- If you must migrate, have the old model write a *model-agnostic* version of its memory first — explicit, no shorthand, all implicit patterns spelled out
- Think of it like employee offboarding: the leaving employee writes a proper handover doc, not just hands over their personal notebook

!!! info "The right migration strategy"
    `Step 1:` Have the current model rewrite its memory in plain, explicit language — no shortcuts, no assumed context.

    `Step 2:` Bootstrap the new model with that explicit version.

    `Step 3:` Switch models.

    It's the difference between handing a new colleague your personal notebook vs. writing them a proper onboarding doc.

**Want to go deeper?** → *[Blog post coming soon: "Model-Memory Coupling: Why Your AI's Memory Is a Dialect, Not a Language" — A2H Labs]*

---

*More findings coming as we observe them.*
