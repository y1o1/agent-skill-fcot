# FCoT — Falsification Chain of Thought

A Claude Code skill that verifies AI judgments through falsificationism. Counter sycophancy bias by systematically attempting to disprove your own conclusions.

## The Problem

LLMs tend toward sycophancy — agreeing with users even when they shouldn't. When an AI says "yes, that's a good approach," how do you know it actually evaluated the alternatives?

## The Solution

FCoT applies Popper's falsificationism to AI reasoning:

1. Treat every judgment as a hypothesis
2. Enumerate counter-arguments against it
3. Pre-declare specific conditions that would dismiss each counter-argument (FN bias)
4. Verify each condition
5. Only confirm the judgment if all counter-arguments are dismissed

This transforms agreement from "I can't think of why I'm wrong" (argument from ignorance) into "I defined what would prove me wrong, checked each case, and none held" (self-binding logical inference).

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

## Output

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

See [more examples](docs/examples/) — including cases where FCoT [confirms a sound judgment](docs/examples/password-hashing.md).

## Theory

**FCoT = FN bias + Falsification + Chain of Thought**

- **FN bias (False Negative bias):** Pre-declaring dismissal conditions prevents post-hoc rationalization
- **Falsification (Popper):** Hypotheses gain credibility by surviving refutation attempts, not by accumulating confirmation
- **Chain of Thought:** Step-by-step elimination of counter-arguments creates an auditable reasoning trace

## Prior Art

See [APPROACH.md](APPROACH.md) for how FCoT relates to existing research (POPPER, CRITIC, Constitutional AI, Debate, etc.) and what it adds.

## Feedback

Questions, ideas, or bug reports? Post in [Feedback & Discussion](https://github.com/y1o1/agent-skill-fcot/issues/1).

## License

MIT
