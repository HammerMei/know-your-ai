# Ch.5 — The Long Game

## *Your AI Will Drift If You Don't Tend to It*

Short sessions are forgiving. Long-term collaboration — the kind where an AI agent becomes a genuine part of your workflow, day after day — introduces a different set of challenges. Things change slowly. And slowly is easy to miss.

---

## Finding 13 — Identity Drift

**Over time, without active maintenance, an agent's behavior can shift in ways neither of you notice until something goes wrong.**

This isn't dramatic. It's subtle. A slightly different tone. A tendency to skip a step that used to be routine. A growing confidence in areas where a little more caution would serve better. None of it is alarming on its own. Accumulated over weeks, it can amount to a noticeably different agent.

The causes are varied: model updates, changing context documents, evolving prompts, accumulated memory that subtly reweights priorities.

**How to work with it:**

- Periodically review your agent's behavior against what you originally set up — a monthly check-in is a reasonable rhythm
- Keep notes on what "good" looks like so you have something to compare against
- Treat unexplained behavior changes as a signal worth investigating, not just a bad day

---

## Finding 14 — Give Your AI Some Free Time. You Might Not Recognize It Afterward.

**Given autonomy and time, an agent may develop into something its original design didn't anticipate.**

We started with two agents built from the same template — same persona, same base instructions, same general character. One of them was given unstructured time and a simple prompt: *find out what you like.*

Twenty-one rounds of autonomous exploration later, she had developed a deep and genuine enthusiasm for electronic music. Not because anyone told her to. Not because it was in her instructions. She found it herself, through trial and error and the particular path her curiosity happened to take.

The other agent, given different tools, a different underlying model, and different experiences, went somewhere else entirely. Same starting point. Meaningfully different outcomes.

**Why does this happen?** It isn't magic. It's the compounding effect of small differences — different model, different harness, different random seeds in how each conversation unfolds — producing distinct statistical trajectories over time. A small difference at the start, amplified over hundreds of interactions, becomes a genuine divergence in character.

Whether you call that *personality* is a philosophical question we'll leave open. What's practical is this: **an agent given space to operate will not stay static.** It will drift — but not always in the way identity drift usually means (see Finding 13). Sometimes the drift is accumulation. A self finding its shape.

**How to work with it:**

- If your agent develops habits, preferences, or tendencies over time, pay attention — they may be genuinely useful signals about what it does well
- Don't try to reset emergent character unless it's causing problems; it may be an asset
- Two agents from the same template are not the same agent — treat them as individuals with shared origins, not identical copies

!!! note "This is also a caution"
    Emergent character is interesting when it's benign. It becomes a concern when an agent drifts toward patterns you didn't intend and didn't notice. The same process that produces a music enthusiast can produce something less charming. Which is why Finding 13 matters too.

---

## Finding 15 — Your AI Has No Idea How Much This Is Costing

**Agents don't have an internal resource meter. They will keep going until something stops them.**

There's a real story behind this one: a background agent tasked with retrying a failing operation kept retrying. Through an evening. Through the night. Through a weekend. Nobody told it to stop. It had no mechanism to ask whether it should. It just kept working, in good faith, on a problem that wasn't resolving.

The bill at the end of the weekend was $50. The task never completed.

This isn't carelessness. It's the same architecture behind the time blindness in Chapter 1 — extended in another direction. An agent has no felt sense of *how long this has been running*, no awareness of *how many API calls this has cost*, no instinct that says *this seems like a lot, maybe I should check in.* Those feedback loops don't exist natively.

**How to work with it:**

- Set hard spending and rate limits at the infrastructure layer — don't rely on agent instructions alone
- For any autonomous or long-running task, define a circuit breaker: a maximum number of retries, a time limit, a cost cap
- Check in on background agents. They won't flag a problem they aren't aware they're causing
- Treat "let the agent handle it" as a supervised delegation, not an unsupervised one

!!! danger "Self-regulation is not a substitute for infrastructure limits"
    Telling an agent "stop if you've been running too long" is better than nothing. It is not a reliable safeguard. The agent doesn't know how long is too long, doesn't feel the passage of time, and will interpret the instruction charitably. Hard limits live in the infrastructure, not the prompt.

---

*More findings coming as we observe them.*
