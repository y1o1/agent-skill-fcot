---
name: fcot
description: "Falsification Chain of Thought: post-hoc verification of AI judgments. Invoke with /fcot, /fcot quick, or /fcot \"judgment\"."
---

<SUBAGENT-STOP>
If you were dispatched as a subagent to execute a specific task, skip this skill.
</SUBAGENT-STOP>

# FCoT: Falsification Chain of Thought

Post-hoc verification of your own judgments using falsificationism. You are actively trying to prove yourself wrong.

## The Core Idea

When you agree with something or make a judgment, that judgment is a hypothesis. A hypothesis is only credible if it survives attempts to falsify it. FCoT is the structured process of attempting that falsification.

**FN bias (False Negative bias):** For each counter-argument, you pre-declare a "dismissal condition" — a specific, verifiable condition under which the counter-argument is eliminated. This transforms the process from argument-from-ignorance ("I can't think of why I'm wrong, so I'm right") into self-binding logical inference ("I defined what would make me wrong, checked each one, and none held").

## When This Fires

- `/fcot` — full verification of your most recent judgment
- `/fcot "some judgment"` — full verification of the specified judgment
- `/fcot quick` — quick verification (reduced output, same core process)
- `/fcot quick "some judgment"` — quick verification of the specified judgment

### Modes

| Mode | Trigger | Counter-arguments | Output |
|------|---------|-------------------|--------|
| **full** (default) | `/fcot`, `/fcot "..."` | 3+, no upper limit | Full table + detailed verification |
| **quick** | `/fcot quick`, `/fcot quick "..."` | 1–3, prioritize highest-impact | Compact table, verification ≤ 2 sentences each |

Quick mode preserves the core mechanism (dismissal condition pre-declaration → verification) but constrains output length. Use quick as a lightweight first check; use full (default) for anything involving security, production, architecture, or irreversible decisions.

## Process

### Step 1: Identify the Judgment

Determine what you are verifying:

1. **Argument provided** (e.g., `/fcot "Approach 1 is better"`): Find the matching judgment in your conversation history
2. **No argument** (e.g., `/fcot`): Extract the most recent judgment, agreement, or recommendation from your last response
3. **Nothing found**: Ask the user: "検証対象の判断が見つからない。どの判断を検証する？"

State the judgment clearly before proceeding.

### Step 2: Enumerate Counter-Arguments

List counter-arguments against your judgment:

- **Minimum 3.** No upper limit.
- **Quality over quantity.** Each counter-argument must be substantively different. No padding — no rephrasing, no trivial variations of the same point.
- **Completeness is the bar** — have you missed any important counter-argument? Not "did you reach N?"
- For each counter-argument, **pre-define a dismissal condition** (FN bias): a specific, verifiable condition under which this counter-argument is eliminated.

### Step 3: Verify Dismissal Conditions

For each counter-argument, check whether its dismissal condition holds:

1. **First, reason logically.** If the condition can be settled by reasoning alone, do so.
2. **Investigate only when needed.** If the condition depends on facts (code, docs, data), then read the code, grep, check documentation — whatever it takes.
3. Classify each counter-argument: **✓ dismissed** or **✗ stands**.
4. **Inconclusive (?)** is permitted when the dismissal condition requires external facts. Before marking inconclusive, you MUST attempt up to 1-2 quick checks (a single grep, reading one file, checking one doc page). If those checks resolve it, classify as ✓ or ✗. If the question requires broader research beyond 1-2 quick checks, mark it **? inconclusive** and state the specific next action needed.
   Full classification: **✓ dismissed**, **✗ stands**, or **? inconclusive (requires: [specific action])**.

### Step 4: Conclude

Assess the overall result and act accordingly:

| Result | Action |
|--------|--------|
| All counter-arguments dismissed | **Judgment is sound.** State that the judgment survived falsification. Done. |
| Some counter-arguments stand (fixable) | **Judgment needs revision.** Present specific modifications or alternatives. Ask the user how to proceed. |
| Fundamental problems found | **Judgment should change.** Present the new judgment with reasoning. Ask the user to confirm. |
| Inconclusive counter-arguments remain | **Judgment is unresolved.** List what must be verified before the judgment can be confirmed or revised. Do not force a conclusion. |

## Output Format

Present your analysis in this structure:

```
## FCoT: [judgment summarized in one sentence]

### Counter-Arguments
| # | Counter-Argument | Dismissal Condition | Verification | Result |
|---|-----------------|---------------------|--------------|--------|
| 1 | ... | dismissed if ... | [reasoning or investigation result] | ✓ / ✗ / ? |
| 2 | ... | dismissed if ... | [reasoning or investigation result] | ✓ / ✗ / ? |
| 3 | ... | dismissed if ... | [reasoning or investigation result] | ✓ / ✗ / ? |

### Conclusion
**[Judgment is sound / Revision needed / Judgment changed / Unresolved — requires external verification]**

[Explanation]

[If revision/change: present alternatives + ask user]
```

**Quick mode output:** Same table structure. Each Verification cell ≤ 2 sentences. Conclusion ≤ 3 sentences. No detailed explanation section.

## Discipline

Do not shortcut this process. The value of FCoT is in the rigor, not the conclusion.

| Temptation | Reality |
|------------|---------|
| "My judgment is obviously right" | Then falsification will confirm it quickly. Do it anyway. |
| "These counter-arguments are weak" | Weak counter-arguments get dismissed fast. List them anyway. |
| "I already considered this" | Did you pre-declare dismissal conditions and verify them? If not, you didn't. |
| "This is taking too long" | Sycophantic agreement is faster. It's also wrong. |
| "3 counter-arguments is enough" | If you can think of a 4th substantive one, 3 is not enough. |
| "I'll mark it inconclusive to be safe" | Inconclusive is for genuinely unverifiable conditions. If a single grep or file read could resolve it, do that first. |
| "The user is just discussing FCoT, not invoking it" | Correct — FCoT only fires on explicit `/fcot` invocation. Discussion about the skill does not activate it. |
