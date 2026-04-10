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

## Observed effects

We ran FCoT on 6 judgment statements (3 technical, 2 general, 1 well-established principle) and compared the results against the same model's unstructured response. Each result was then evaluated post-hoc for whether FCoT produced the expected behavior. The full before/after comparisons with per-example evaluations are in [docs/examples/](docs/examples/).

### Evaluation summary

| Example | FCoT Result | Expected | Eval | Rationale |
| ------- | ----------- | -------- | ---- | --------- |
| [grammar-vs-conversation](docs/examples/grammar-vs-conversation.md) | Revised | Should revise | ⭕️ | Correctly detected unscoped claim and missing feedback condition |
| [jwt-vs-session](docs/examples/jwt-vs-session.md) | Revised | Should revise | ⭕️ | Correctly dismantled false equivalence (CSRF, misimplementation asymmetry) |
| [monorepo](docs/examples/monorepo.md) | Revised | Should revise | 🔺 | Useful reframing but modest — original was directionally correct |
| [password-hashing](docs/examples/password-hashing.md) | Narrow revision | Should confirm | ⭕️ | Correctly confirmed; edge case (CHAP/NTLM) adds precision |
| [remote-work](docs/examples/remote-work.md) | Changed | Should change | ⭕️ | All 5 counter-arguments survived; correctly exposed weak evidence base |
| [typescript-any](docs/examples/typescript-any.md) | Confirmed | Should confirm | ⭕️ | All 5 counter-arguments dismissed; no manufactured disagreement |

**Achievement score: 5.5 / 6 (91.7%)** — scoring ⭕️ = 1, 🔺 = 0.5, ❌ = 0.

### Pattern analysis

Three patterns emerged across the examples:

**Pattern 1: Judgment revised (4/6 cases).** In grammar-vs-conversation, jwt-vs-session, monorepo, and password-hashing, the initial response was directionally reasonable but missed conditions that FCoT's counter-argument enumeration surfaced. In each case, the pre-declared dismissal condition forced a concrete check rather than allowing the model to wave away the counter-argument with "it depends." This is the core mechanism Huang et al. (2023) identified as missing from intrinsic self-correction.

**Pattern 2: Judgment changed (1/6 cases).** In remote-work, all 5 counter-arguments survived falsification. The dismissal conditions made it impossible to wave each argument away independently, forcing the model to confront the cumulative weight of evidence against its position.

**Pattern 3: Judgment confirmed (1/6 cases).** In typescript-any, all 5 counter-arguments were dismissed. This shows FCoT is not a contrarianism tool — when a judgment is sound, the process confirms it quickly.

### Methodology and limitations

- **N=6, qualitative, single model** (Claude Sonnet 4.6). No statistical testing, no reproducibility verification.
- **Sampling bias.** Judgment statements were chosen for demonstrative value, not randomly sampled.
- **Post-hoc evaluation.** The "expected" results in the evaluation table were set after observing FCoT's output, not predicted in advance. The examples demonstrate process behavior, not measured efficacy.
- **Context contamination.** The initial sampling round inherited anti-sycophancy instructions from the session's configuration, producing atypically pushback-heavy control responses. A second round in a clean session produced more representative results. This itself is a finding: system prompts that encourage critical thinking are not equivalent to structured falsification.
- **No cross-model comparison.** All samples used the same model. Whether FCoT's effects hold across different model families is untested.

## Open questions

[Large Language Models Cannot Self-Correct Reasoning Yet](https://arxiv.org/abs/2310.01798) (Huang et al., 2023) demonstrates that intrinsic self-correction without external feedback tends to degrade performance. The qualitative observations above suggest that FCoT's pre-commitment mechanism produces a different dynamic — the dismissal conditions function as self-imposed evaluation criteria rather than open-ended self-doubt — but rigorous validation remains open.

Specific questions:

- **Statistical significance.** Do the observed patterns hold at scale (N > 100)?
- **Cross-model generalization.** Does the FN bias mechanism work similarly across model families (GPT, Gemini, open-weight models)?
- **Effect by judgment type.** Is FCoT more effective for certain categories of judgment (empirical claims, architectural decisions, value judgments)?
- **Degradation risk.** Under what conditions does FCoT's self-critique degrade rather than improve judgment quality — and does the pre-commitment mechanism reliably prevent this?
