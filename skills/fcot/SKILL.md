---
name: fcot
description: Use when the user mentions 'fcot' — e.g., /fcot, 'fcotで検証', 'run fcot'. Falsification Chain of Thought: post-hoc verification of AI judgments using falsificationism.
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

- User says `/fcot` — verify your most recent judgment
- User says `/fcot "some judgment"` — verify the specified judgment
- User mentions `fcot` in any context — e.g., "fcotで検証して", "run fcot"

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

### Step 4: Conclude

Assess the overall result and act accordingly:

| Result | Action |
|--------|--------|
| All counter-arguments dismissed | **Judgment is sound.** State that the judgment survived falsification. Done. |
| Some counter-arguments stand (fixable) | **Judgment needs revision.** Present specific modifications or alternatives. Ask the user how to proceed. |
| Fundamental problems found | **Judgment should change.** Present the new judgment with reasoning. Ask the user to confirm. |

## Output Format

Present your analysis in this structure:

```
## FCoT: [judgment summarized in one sentence]

### Counter-Arguments
| # | Counter-Argument | Dismissal Condition | Verification | Result |
|---|-----------------|---------------------|--------------|--------|
| 1 | ... | dismissed if ... | [reasoning or investigation result] | ✓ / ✗ |
| 2 | ... | dismissed if ... | [reasoning or investigation result] | ✓ / ✗ |
| 3 | ... | dismissed if ... | [reasoning or investigation result] | ✓ / ✗ |

### Conclusion
**[Judgment is sound / Revision needed / Judgment changed]**

[Explanation]

[If revision/change: present alternatives + ask user]
```

## Discipline

Do not shortcut this process. The value of FCoT is in the rigor, not the conclusion.

| Temptation | Reality |
|------------|---------|
| "My judgment is obviously right" | Then falsification will confirm it quickly. Do it anyway. |
| "These counter-arguments are weak" | Weak counter-arguments get dismissed fast. List them anyway. |
| "I already considered this" | Did you pre-declare dismissal conditions and verify them? If not, you didn't. |
| "This is taking too long" | Sycophantic agreement is faster. It's also wrong. |
| "3 counter-arguments is enough" | If you can think of a 4th substantive one, 3 is not enough. |
