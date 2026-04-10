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

FCoT produces a structured table:

| # | Counter-Argument | Dismissal Condition | Verification | Result |
|---|-----------------|---------------------|--------------|--------|
| 1 | Alternative X is faster | dismissed if latency is not a constraint | Project has no latency SLA | ✓ |
| 2 | Approach breaks with >1M rows | dismissed if data stays under 1M | Roadmap shows 10M rows by Q3 | ✗ |

Followed by a conclusion: **sound**, **needs revision**, or **changed**.

## Theory

**FCoT = FN bias + Falsification + Chain of Thought**

- **FN bias (False Negative bias):** Pre-declaring dismissal conditions prevents post-hoc rationalization
- **Falsification (Popper):** Hypotheses gain credibility by surviving refutation attempts, not by accumulating confirmation
- **Chain of Thought:** Step-by-step elimination of counter-arguments creates an auditable reasoning trace

## Prior Art

See [APPROACH.md](APPROACH.md) for how FCoT relates to existing research (POPPER, CRITIC, Constitutional AI, Debate, etc.) and what it adds.

## License

MIT
