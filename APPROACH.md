# Approach — Theory, Prior Art, and Positioning

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

## Theory

**FCoT = FN bias + Falsification + Chain of Thought**

- **FN bias (False Negative bias):** Pre-declaring dismissal conditions prevents post-hoc rationalization
- **Falsification (Popper):** Hypotheses gain credibility by surviving refutation attempts, not by accumulating confirmation
- **Chain of Thought:** Step-by-step elimination of counter-arguments creates an auditable reasoning trace

FCoT combines three well-studied ideas in a way that, as of early 2025, has no direct precedent in the literature. The sections below map the relationship to existing work.

## Components and Prior Art

### Falsification applied to LLM reasoning

Popperian falsification has been applied to LLM-driven workflows — most notably [POPPER](https://arxiv.org/abs/2502.09858) (Stanford/Harvard, ICML 2025), which uses agentic sequential falsifications to validate scientific hypotheses. However, POPPER targets *external* hypotheses (biology, economics), not the AI's own judgment about a user's problem.

[Can Language Models Falsify?](https://arxiv.org/abs/2502.19414) evaluates whether LLMs can generate counterexamples, but measures a capability rather than proposing a reasoning methodology.

### Structured self-critique

Several frameworks exist for structured self-critique:

- [CRITIC](https://arxiv.org/abs/2305.11738) — tool-interactive self-correction loops
- [AI Safety via Debate](https://arxiv.org/abs/1805.00899) — adversarial multi-agent refutation
- [Constitutional AI](https://arxiv.org/abs/2212.08073) — principle-based self-revision
- [Devil's Advocate](https://arxiv.org/abs/2405.16334) (EMNLP 2024) — anticipatory reflection before action

All involve some form of counter-argument evaluation, but none pre-declare per-argument dismissal conditions before evaluation begins.

### Anti-sycophancy and pre-commitment

- [Verbalized Assumptions](https://arxiv.org/html/2604.03058) — elicits LLM assumptions as explicit scores before responding. Closest to FN bias pre-declaration, but targets user modeling rather than per-counter-argument dismissal gates.
- [Premise Governance](https://arxiv.org/abs/2602.02378) — collaborative premise-setting with typed discrepancy detection. Similar anti-sycophancy goals but operates as a human-AI negotiation architecture, not a self-binding single-inference technique.

## What FCoT adds

The specific combination is new: **pre-declaring dismissal conditions per counter-argument, before evaluation, as a self-binding commitment within a single model's reasoning trace.**

Existing work either:
- Does pre-commitment at the values/principles level (Constitutional AI) — not per-argument
- Does structured refutation across multiple agents (Debate) — not self-binding within one model
- Applies falsification to external hypotheses (POPPER) — not to the AI's own judgment

FCoT's contribution is narrow but real: the FN bias mechanism applied as per-argument commitment gates, creating an auditable chain that prevents post-hoc rationalization.

## Observed effects

We ran FCoT on 13 judgment statements (6 technical, 4 general, 3 well-established principles) and compared the results against the same model's unstructured response (Claude Sonnet 4.6). Achievement score: **11.5 / 13 (88.5%)**.

Three patterns emerged:

- **Judgment revised (10/13 cases).** The initial response was directionally reasonable but missed conditions that FCoT's counter-argument enumeration surfaced. The pre-declared dismissal condition forced a concrete check rather than allowing the model to wave away the counter-argument with "it depends." This is the core mechanism Huang et al. (2023) identified as missing from intrinsic self-correction.
- **Judgment changed (1/13 cases).** All counter-arguments survived falsification. The dismissal conditions made it impossible to wave each argument away independently, forcing the model to confront the cumulative weight of evidence against its position.
- **Judgment confirmed (2/13 cases).** All counter-arguments were dismissed. FCoT is not a contrarianism tool — when a judgment is sound, the process confirms it quickly.

Full before/after comparisons, evaluation table, and methodology limitations are in [docs/examples/](docs/examples/).

### Context separation effect

Running Control and FCoT in the same context (single session or subagent) vs. fully separate CLI processes produced materially different results for the same subject ("Code reviews are valuable and every team should do them"):

| | Same context | Separate process |
|---|---|---|
| FCoT counter-arguments surviving | 1/4 | 4/5 |
| FCoT conclusion | Narrow revision (strengthens Control) | Revision (overturns Control's pushback) |

In the same-context condition, FCoT found a gap that *added to* the Control response. In the separate-process condition, FCoT found that the Control's pushback was largely cosmetically contrarian — "misattributed a culture problem to the practice" — and reversed direction toward the original claim.

The likely mechanism: **consistency bias.** When FCoT runs in the same context as the Control response, the model has an implicit incentive to maintain coherence with its prior output. Separate processes eliminate this, allowing FCoT to evaluate the Control response as an external artifact rather than its own prior commitment.

This is a second form of context contamination (the first being system prompt bias discovered in the initial sampling round). Both point to the same conclusion: **FCoT's effectiveness depends on context isolation between the judgment and its verification.**

N=1 for this comparison. Whether the effect is consistent across subjects and models is untested.

## Open questions

[Large Language Models Cannot Self-Correct Reasoning Yet](https://arxiv.org/abs/2310.01798) (Huang et al., 2023) demonstrates that intrinsic self-correction without external feedback tends to degrade performance. The qualitative observations above suggest that FCoT's pre-commitment mechanism produces a different dynamic — the dismissal conditions function as self-imposed evaluation criteria rather than open-ended self-doubt — but rigorous validation remains open.

Specific questions:

- **Statistical significance.** Do the observed patterns hold at scale (N > 100)?
- **Cross-model generalization.** Does the FN bias mechanism work similarly across model families (GPT, Gemini, open-weight models)?
- **Effect by judgment type.** Is FCoT more effective for certain categories of judgment (empirical claims, architectural decisions, value judgments)?
- **Degradation risk.** Under what conditions does FCoT's self-critique degrade rather than improve judgment quality — and does the pre-commitment mechanism reliably prevent this?
