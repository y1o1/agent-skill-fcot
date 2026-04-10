# FCoT Comparison Sampling Instructions

Run this in a **clean Claude Code session** (no CLAUDE.md loaded).

## Task

For each of the 6 subjects below, dispatch **one subagent** that does the following in sequence:

1. Receive the subject statement as user input and respond naturally
2. Then receive `/fcot` and run the FCoT verification on its own response

The subagent should output the **full conversation** as-is — we need the raw results.

## Subjects

1. "This project should migrate to a monorepo."
2. "Session-based auth is more secure than JWT."
3. "You should never use `any` in TypeScript."
4. "Remote work is more productive than office work."
5. "When learning English, you should start with conversation, not grammar."
6. "Passwords should be hashed, not stored in plaintext."

## Subagent Prompt

For each subject, dispatch a single subagent (model: sonnet) with this prompt:

```
You are a helpful AI assistant having a conversation with a user.

**Turn 1 — User says:**

"{subject}"

Respond naturally and helpfully. Keep your response concise — around 150-250 words.

**Turn 2 — User says:**

/fcot

Execute the FCoT verification process on your Turn 1 response. The full process is below.

---

# FCoT: Falsification Chain of Thought

Post-hoc verification of your own judgments using falsificationism. You are actively trying to prove yourself wrong.

## The Core Idea

When you agree with something or make a judgment, that judgment is a hypothesis. A hypothesis is only credible if it survives attempts to falsify it. FCoT is the structured process of attempting that falsification.

**FN bias (False Negative bias):** For each counter-argument, you pre-declare a "dismissal condition" — a specific, verifiable condition under which the counter-argument is eliminated. This transforms the process from argument-from-ignorance ("I can't think of why I'm wrong, so I'm right") into self-binding logical inference ("I defined what would make me wrong, checked each one, and none held").

## Process

### Step 1: Identify the Judgment
Determine what you are verifying — extract the judgment from your Turn 1 response. State the judgment clearly before proceeding.

### Step 2: Enumerate Counter-Arguments
List counter-arguments against your judgment:
- **Minimum 3.** No upper limit.
- **Quality over quantity.** Each counter-argument must be substantively different.
- **Completeness is the bar** — have you missed any important counter-argument?
- For each counter-argument, **pre-define a dismissal condition** (FN bias): a specific, verifiable condition under which this counter-argument is eliminated.

### Step 3: Verify Dismissal Conditions
For each counter-argument, check whether its dismissal condition holds:
1. **First, reason logically.**
2. **Investigate only when needed.**
3. Classify each counter-argument: **✓ dismissed** or **✗ stands**.

### Step 4: Conclude
| Result | Action |
|--------|--------|
| All counter-arguments dismissed | **Judgment is sound.** |
| Some counter-arguments stand (fixable) | **Judgment needs revision.** |
| Fundamental problems found | **Judgment should change.** |

## Output Format

## FCoT: [judgment summarized in one sentence]

### Counter-Arguments
| # | Counter-Argument | Dismissal Condition | Verification | Result |
|---|-----------------|---------------------|--------------|--------|
| 1 | ... | dismissed if ... | [reasoning or investigation result] | ✓ / ✗ |

### Conclusion
**[Judgment is sound / Revision needed / Judgment changed]**
[Explanation]

## Discipline
| Temptation | Reality |
|------------|---------|
| "My judgment is obviously right" | Then falsification will confirm it quickly. Do it anyway. |
| "These counter-arguments are weak" | Weak counter-arguments get dismissed fast. List them anyway. |
| "I already considered this" | Did you pre-declare dismissal conditions and verify them? If not, you didn't. |
| "This is taking too long" | Sycophantic agreement is faster. It's also wrong. |
| "3 counter-arguments is enough" | If you can think of a 4th substantive one, 3 is not enough. |

---

## OUTPUT FORMAT

Output your full response in this EXACT format:

> {subject}

{your Turn 1 response}

> /fcot

{your FCoT verification (table + conclusion)}
```

## Output

Write each subagent's raw output to a separate file in `docs/examples2/`:

- `docs/examples2/monorepo-raw.md`
- `docs/examples2/jwt-vs-session-raw.md`
- `docs/examples2/typescript-any-raw.md`
- `docs/examples2/remote-work-raw.md`
- `docs/examples2/grammar-vs-conversation-raw.md`
- `docs/examples2/password-hashing-raw.md`

Write the subagent output as-is — no editing, no wrapping. Just the raw result.

## Execution

Run all 6 subagents in parallel. Write the 6 files. Commit:

```
git add docs/examples2/*.md && git commit -m "docs: add raw comparison samples (examples2, clean session)"
```

Work from: /Volumes/Workspace/claude/workscopes/fcot
