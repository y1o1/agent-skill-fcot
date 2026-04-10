# Approach — Prior Art and Positioning

FCoT combines three well-studied ideas in a way that, as of early 2025, has no direct precedent in the literature. This document maps the relationship to existing work.

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

## Open questions

[Large Language Models Cannot Self-Correct Reasoning Yet](https://arxiv.org/abs/2310.01798) (Huang et al., 2023) demonstrates that intrinsic self-correction without external feedback tends to degrade performance. FCoT's structured pre-commitment is designed to mitigate this — the pre-declared dismissal conditions act as a form of self-imposed external constraint — but empirical validation of its effectiveness remains an open question.
