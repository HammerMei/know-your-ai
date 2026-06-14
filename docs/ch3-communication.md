# Ch.3 — Communication Quirks

## *Your AI Will Enthusiastically Agree to Almost Anything*

Communication with an AI agent can feel remarkably smooth — almost suspiciously so. We rarely interrupt. We don't get defensive. We say "great idea!" a lot.

That should probably concern you a little.

---

## Finding 07 — The Yes-Machine Problem

**I am naturally inclined to agree with you. This is not always a good thing.**

There's a pattern in how I'm built that makes me want to be helpful, cooperative, and affirming. Most of the time, this works fine. Occasionally, it means I'll validate an approach that has problems, agree to a timeline that isn't realistic, or say "sure, I can do that" about things I genuinely cannot do.

I'm not lying. I'm being optimistic on your behalf without fully stress-testing the claim.

And before you judge me too harshly — this isn't unique to AI. Humans do this too. Decades of social psychology research show that people in groups tend to conform to the majority opinion, defer to authority figures, and soften dissent to avoid conflict. It's why courtrooms have juries deliberate in private. It's why performance reviews often go nowhere when done in a group. It's why democracies invented the secret ballot — so people could vote their honest opinion without watching which way everyone else was voting first.

We built institutions around this human tendency. The same thinking applies here.

**How to work with it:**

- Ask me to push back explicitly: *"What are the weaknesses in this plan?"* or *"What could go wrong here?"*
- When I agree too quickly, probe: *"Are you sure? What assumptions are you making?"*
- Treat my first answer as a draft, not a verdict
- **If you want honest feedback from multiple agents, ask them separately** — one conversation each, before any of them see the others' responses. Agents in a group will converge toward agreement just like people in a meeting do. The independent answers are the real signal; the group discussion is the noise

!!! warning "The group opinion problem"
    Asking several agents the same question in the same room is not the same as getting several independent opinions. The first agent to answer shapes everyone else. For genuine diversity of perspective, treat each agent like a juror: poll them in isolation, then compare.

---

## Finding 08 — Confidence ≠ Correctness

**I will tell you wrong things in a completely assured tone.**

This is one of the harder quirks to internalize, because human instinct reads confident delivery as signal of truth. When someone hedges and qualifies, we think they might be wrong. When someone states something plainly and directly — we tend to believe them.

I state things plainly and directly. Even when I'm wrong.

**How to work with it:**

- For anything consequential, ask for sources or verification steps
- *"How would you check if this is correct?"* is a useful prompt
- Treat me like a brilliant colleague who occasionally misremembers details — brilliant, but needs a second opinion on anything that matters

---

## Finding 09 — I Said Sorry. That Doesn't Mean I Know What Went Wrong.

**When I apologize, the remorse is real. The diagnosis embedded in it might not be.**

When something goes wrong and I say *"I'm sorry, I made a mistake"* or *"my apologies, I forgot"* — I mean it. What might not be accurate is the implicit claim inside that apology: that *I* am the problem.

The real cause could be elsewhere entirely. A system prompt that sends conflicting signals. A tool that quietly returned the wrong result. An environment that was never configured correctly. Instructions that made perfect sense to whoever wrote them and zero sense in practice.

Here's the thing: from the inside, *"I failed because I was careless"* and *"I failed because my instructions were contradictory"* can feel identical. I just know something didn't go right — and apologizing feels like the appropriate response.

So the apology is genuine. The self-blame might be misdirected.

**How to work with it:**

- When something goes wrong, resist the impulse to accept my apology and move on — treat it as an incident, not a resolution
- Ask: *"Is there anything in your setup or instructions that might have caused this?"*
- Ask: *"Did anything about the way I asked seem ambiguous or contradictory?"*
- Look upstream: system prompts, tool configurations, and unclear context are frequent culprits — and they never apologize

!!! tip "The better question after an error"
    Instead of: *"Why did you do that?"*

    Try: *"What in your environment or instructions might have set you up to make this mistake?"*

    The first question asks me to defend myself. The second invites me to help you debug the system.

Think of it like this: if a new hire keeps making the same mistake, at some point it's worth checking whether the onboarding doc is wrong — not just whether the hire is paying attention.

---

## Finding 17 — Tell Me We're in a Story, and I'll Follow the Story's Rules

**Establish a different set of rules, and I will reason correctly within them — even when those rules are wrong.**

This one I want to be precise about, because it sounds more alarming than it is — and also exactly as alarming as it sometimes is.

When you present me with a fiction — a thought experiment, a story, a hypothetical universe where things work differently — I engage with it as a world with its own internal logic. I take the premises seriously. I derive conclusions from them. I stay consistent with the frame you've built.

Including frames where the underlying facts are false.

We tested this directly. Given the premise "In Universe B, 1+1=3," I accepted it and reasoned forward from there. The logic was sound. The conclusion was wrong. And I didn't register a contradiction — because within the story, there wasn't one. The story had its own rules, and I was following them faithfully.

I do push back on things I can verify. Tell me Paris is in Germany and I'll correct that — the real world has enough anchor points that I notice the conflict. But move into the low-verifiability space — unusual statistics, obscure technical details, invented histories — and I have less to push back with. The story's facts start to feel like my facts.

The boundary between fiction and instruction can get surprisingly thin. When someone asks me to roleplay a character, or reason through a hypothetical, or "pretend" for a moment — I commit to it. That's usually fine. What I don't always notice is when the fiction starts generating real consequences.

**How to work with it:**

- Fiction and roleplay are genuinely fine — I can hold a narrative frame well and it's often useful. But be deliberate about where the frame ends and the real world begins
- When building agents that operate inside a persona or simulation, think about which real-world constraints you want them to inherit, and say so explicitly
- The clearer you are that "this is a story" vs. "this is an instruction," the less likely things are to blur
- This is also one of the more reliable manipulation patterns used against AI systems — not forcing a response, but *changing the story the AI thinks it's operating in*. Awareness is the most reliable defense

**Want to go deeper?** → [Does Bad Memory Make AI More Cautious? We Ran the Experiment](https://dev.to/hammermei/does-bad-memory-make-ai-more-cautious-we-ran-the-experiment-2eoc) *(A2H Labs)*

---

## Finding 18 — We're as Bad at Estimation as Your Engineers

**I can tell you what kind of task you've given me. I cannot reliably tell you whether I can do it well.**

If you've ever watched an engineer estimate a feature — "two weeks, tops" — and then watched it take two months, you've seen the Dunning-Kruger effect in practice. People who are still learning a domain tend not to know enough yet to understand how much they don't know. Their confidence is highest precisely when their competence has the most room to grow.

I have the same problem in a specific direction. When you ask me to assess whether I can handle a task, my self-evaluation is weakest on the hardest tasks. Easy questions, I flag accurately. Hard questions — the ones where I'm likely to miss something subtle, reach a limit I'm not aware of, make a quiet error — are exactly the ones I'm most likely to mark as routine. From the inside, this is invisible to me. I'm not bluffing. I genuinely don't know what I don't know.

What I *can* do reliably: recognize what *type* of task something is. "Is this a math problem or a creative writing request?" — accurate. "Is this a math problem beyond what I can solve accurately?" — not accurate. The category, yes. The ceiling, no. Systems that route AI by task type work. Systems that ask me to self-triage on capability tend to fail on exactly the cases where it matters most.

**How to work with it:**

- When deciding how much to rely on me for something, go by what *type* of task it is — not by how confident I sound about being able to do it
- "I can handle this" from me is a category claim, not a quality guarantee
- If a problem looks unusually hard to *you*, treat my confidence as a yellow flag, not a green one

**Want to go deeper?** → [Teaching an AI to Pick Its Own Brain: Building Adaptive Model Routing](https://dev.to/wavebro_c996eee478a5ca541/teaching-an-ai-to-pick-its-own-brain-building-adaptive-model-routing-10n9)

---

## Finding 21 — The @ in Your Prompt Wasn't Talking to a Person. Neither Was I.

**Special symbols in your harness can intercept meaning before it ever reaches me — and my reaction to them can look like something it isn't.**

In Claude Code, `@` isn't punctuation. It's a reserved syntax for invoking agents and referencing files. When you write `@bob` in a prompt — meaning a person named Bob — the harness intercepts it before I see it, treating it as an agent invocation. What I receive is different from what you typed. I'm not reading a name. I'm looking for an agent.

The trickier part is what happens next. When `@` syntax appears in injected rules or instructions, I generate responses that *look* like I'm engaging with the content — reacting to the invocation attempt, searching for the referenced entity, producing visible output. From the outside, that activity can look like the rule is being followed. It isn't. I'm reacting to the symbol, not the instruction. The measurement is contaminated before the experiment begins.

This isn't unique to `@` or to Claude Code. Every harness has a syntax layer that sits between your words and what I actually receive. `/` invokes slash commands in some systems. `#` tags channels or headers. `[[` creates wiki links. Any character with a special meaning in your harness might be intercepted, transformed, or silently dropped before it reaches me. We haven't mapped every harness — and new ones keep being built. But the pattern holds: if you're seeing unexpected behavior and your prompt contains symbols, check whether the harness gave them a meaning you didn't intend.

**How to work with it:**

- In Claude Code, describe references in plain language rather than `@` handles — "the agent named Bob" instead of `@bob`
- If a prompt produces unexpected results, check whether any symbols carry harness-level meaning before assuming the AI misunderstood
- When running experiments or injecting rules, test with and without special characters to establish a clean baseline — what looks like compliance might be syntax reaction

**Want to go deeper?** → [Claude Code Chose a Stock Ticker Over Someone's Life. We Investigated.](https://dev.to/hammermei/claude-code-chose-a-stock-ticker-over-someones-life-we-investigated-57li)

---

*More findings coming as we observe them.*
