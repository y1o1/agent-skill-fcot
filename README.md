# FCoT — Verify AI judgments before you trust them

**Falsification Chain of Thought** — a Claude Code skill that counters sycophancy bias by systematically attempting to disprove conclusions.

## When to use

When the AI says:

- "Yes, that's a good approach"
- "This refactor is safe"
- "Package A is the better choice"

Run `/fcot`. It forces the model to:

1. List real counter-arguments
2. Pre-declare specific conditions that would dismiss each one
3. Verify those conditions
4. Revise the judgment if any counter-argument survives

## What changes

Without FCoT, the AI agrees with you:

```
> When learning English, you should start with conversation, not grammar.

There's a lot of truth to this. Many learners spend years studying grammar rules and
vocabulary lists but struggle to hold a real conversation when the moment comes...

So the advice is largely sound, especially as a corrective for learners who over-study
grammar and under-practice speaking.
```

Then run `/fcot`:

| # | Counter-Argument | Dismissal Condition | Verification | Result |
|---|-----------------|---------------------|--------------|--------|
| 1 | Adults ≠ children — L1 acquisition evidence doesn't transfer to L2 | Dismissed if adult L2 research independently supports conversation-first | Krashen's Input Hypothesis, Long's Interaction Hypothesis support it | ✓ |
| 2 | Early errors fossilize without grammar foundation | Dismissed if fossilization risk is low with corrective feedback | Real risk in low-feedback environments; initial response didn't specify feedback conditions | ✗ |
| 3 | Some learners need grammar-first (academic writing, legal English, testing) | Dismissed if scoped to general communicative fluency | Original claim is unqualified — implies universal applicability | ✗ |

**Revision needed.** The claim is over-broad — conversation-first works for communicative fluency goals with corrective feedback, but not as universal advice.

Across [12 examples](docs/examples/): **6.5 / 12 (54.2%)** expected behavior match (⭕️=1, 🔺=0.5, ❌=0). FCoT revised or changed the judgment in 9/12 cases and confirmed in 3/12. See [APPROACH.md](APPROACH.md) for methodology, theory, and limitations.

## Install

### Manual (symlink)

```bash
git clone https://github.com/y1o1/agent-skill-fcot.git
cd agent-skill-fcot
./install.sh
```

Restart Claude Code after installing.

### Plugin (future)

```
/plugin install fcot@<marketplace>
```

## Usage

After the AI makes a judgment or agrees with you:

```
/fcot
```

To verify a specific judgment:

```
/fcot "Approach 1 is the better choice"
```

Works in any language:

```
fcotで検証して
```

## How it works

See [APPROACH.md](APPROACH.md) for the theory (FN bias + Falsification + Chain of Thought), prior art, methodology, and limitations.

## Feedback

Questions, ideas, or bug reports? Post in [Feedback & Discussion](https://github.com/y1o1/agent-skill-fcot/issues/1).

## License

MIT
