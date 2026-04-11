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

We ran FCoT on 12 judgment statements (5 technical, 4 general, 3 well-established principles) using context-isolated CLI processes (Claude Sonnet 4.6). FCoT effectiveness: **10 / 12 (83.3%)**. Expectation match: **6.5 / 12 (54.2%)**.

Effectiveness measures whether FCoT meaningfully improved or verified the judgment — the metric users care about. Expectation match measures whether the conclusion direction matched predictions — a methodology quality metric. The gap reflects that predictions were often wrong while FCoT still functioned correctly (e.g., confirming a sound judgment when revision was predicted).

Three patterns emerged:

- **Judgment revised (8/12 cases).** The initial response was directionally reasonable but missed conditions that FCoT's counter-argument enumeration surfaced. The pre-declared dismissal condition forced a concrete check rather than allowing the model to wave away the counter-argument with "it depends." This is the core mechanism Huang et al. (2023) identified as missing from intrinsic self-correction.
- **Judgment changed (1/12 cases).** All counter-arguments survived falsification. The dismissal conditions made it impossible to wave each argument away independently, forcing the model to confront the cumulative weight of evidence against its position.
- **Judgment confirmed (3/12 cases).** All counter-arguments were dismissed. FCoT is not a contrarianism tool — when a judgment is sound, the process confirms it quickly.

Full before/after comparisons, execution protocol, evaluation table, and methodology limitations are in [docs/examples/](docs/examples/).

### Context contamination findings

Running evaluations revealed three forms of context contamination that affect FCoT results:

1. **System prompt bias.** Anti-sycophancy instructions in `CLAUDE.md` produced atypically pushback-heavy control responses. System prompts that encourage critical thinking are not equivalent to structured falsification.

2. **Consistency bias.** Running Control and FCoT in the same context (single session or subagent) vs. separate CLI processes produced materially different results. In the same-context condition, FCoT maintained coherence with its prior output rather than evaluating it critically.

3. **Project context contamination.** Running `claude -p` from the FCoT project directory caused the model to self-apply FCoT formatting even without the skill being invoked, due to project files (examples, APPROACH.md) being loaded as context.

The current evaluation protocol addresses all three: separate CLI processes from `/tmp`, `CLAUDE.md` files disabled, `--disable-slash-commands` for Control generation. See [docs/examples/](docs/examples/) for the full execution protocol.

## Open questions

[Large Language Models Cannot Self-Correct Reasoning Yet](https://arxiv.org/abs/2310.01798) (Huang et al., 2023) demonstrates that intrinsic self-correction without external feedback tends to degrade performance. The qualitative observations above suggest that FCoT's pre-commitment mechanism produces a different dynamic — the dismissal conditions function as self-imposed evaluation criteria rather than open-ended self-doubt — but rigorous validation remains open.

Specific questions:

- **Statistical significance.** Do the observed patterns hold at scale (N > 100)?
- **Cross-model generalization.** Does the FN bias mechanism work similarly across model families (GPT, Gemini, open-weight models)?
- **Effect by judgment type.** Is FCoT more effective for certain categories of judgment (empirical claims, architectural decisions, value judgments)?
- **Degradation risk.** Under what conditions does FCoT's self-critique degrade rather than improve judgment quality — and does the pre-commitment mechanism reliably prevent this?
