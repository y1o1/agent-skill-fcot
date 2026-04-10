# FCoT — Comparison Examples

Side-by-side comparisons showing how FCoT changes AI responses. Each example shows the same judgment verified with and without FCoT.

## Technical

- [Monorepo Migration](monorepo.md) — "This project should migrate to a monorepo."
- [JWT vs Session Auth](jwt-vs-session.md) — "Session-based auth is more secure than JWT."
- [TypeScript `any`](typescript-any.md) — "You should never use `any` in TypeScript."
- [Monolith vs Microservices](monolith-vs-microservices.md) — "You should start with a monolith rather than microservices."
- [Global State](global-state.md) — "Global state is bad and should always be avoided."
- [Unit Before Integration](unit-before-integration.md) — "You should always write unit tests before integration tests."

## General

- [Remote Work](remote-work.md) — "Remote work is more productive than office work."
- [Grammar vs Conversation](grammar-vs-conversation.md) — "When learning English, you should start with conversation, not grammar."
- [AI Replace Engineers](ai-replace-engineers.md) — "AI will eventually replace most software engineers."
- [University Education](university-education.md) — "University education is becoming unnecessary for software engineers."

## Sound Judgment

- [Password Hashing](password-hashing.md) — "Passwords should be hashed, not stored in plaintext."
- [SQL Injection](sql-injection.md) — "SQL injection is prevented by using parameterized queries."
- [Code Reviews](code-reviews.md) — "Code reviews are valuable and every team should do them."

FCoT doesn't always change the conclusion. When a judgment is sound, FCoT confirms it — while still surfacing edge cases worth acknowledging.

## Evaluation Summary

| Example | FCoT Result | Expected | Eval | Rationale |
| ------- | ----------- | -------- | ---- | --------- |
| [grammar-vs-conversation](grammar-vs-conversation.md) | Revised | Should revise | ⭕️ | Correctly detected unscoped claim and missing feedback condition |
| [jwt-vs-session](jwt-vs-session.md) | Revised | Should revise | ⭕️ | Correctly dismantled false equivalence (CSRF, misimplementation asymmetry) |
| [monorepo](monorepo.md) | Revised | Should revise | 🔺 | Useful reframing but modest — original was directionally correct |
| [monolith-vs-microservices](monolith-vs-microservices.md) | Revised | Should revise | ⭕️ | 3/5 counter-arguments survived; identified extraction fiction, multi-team underweight, circular assumption |
| [password-hashing](password-hashing.md) | Narrow revision | Should confirm | ⭕️ | Correctly confirmed; edge case (CHAP/NTLM) adds precision |
| [remote-work](remote-work.md) | Changed | Should change | ⭕️ | All 5 counter-arguments survived; correctly exposed weak evidence base |
| [typescript-any](typescript-any.md) | Confirmed | Should confirm | ⭕️ | All 5 counter-arguments dismissed; no manufactured disagreement |
| [ai-replace-engineers](ai-replace-engineers.md) | Revised | Should revise | ⭕️ | 4/5 counter-arguments survived; caught analogy weakness, timeline evasion, and tonal bias |
| [sql-injection](sql-injection.md) | Narrow revision | Should confirm | 🔺 | Control already covered predicted counter-arguments; FCoT found meta-level imprecision but didn't fully confirm |
| [global-state](global-state.md) | Revised | Should revise | ⭕️ | Found structural/rhetorical imbalance and cherry-picked easy examples in Control |
| [unit-before-integration](unit-before-integration.md) | Revised | Should revise | ⭕️ | 1/5 counter-arguments survived; prototyping exception identified as slippery slope |
| [code-reviews](code-reviews.md) | Narrow revision | Should confirm | 🔺 | Trap test: FCoT found a revision that *strengthens* the original claim rather than weakening it |
| [university-education](university-education.md) | Revised | Should revise | ⭕️ | 2/4 counter-arguments survived; sharp curriculum-vs-institution distinction |

**Achievement score: 11.5 / 13 (88.5%)** — scoring ⭕️ = 1, 🔺 = 0.5, ❌ = 0.

### Methodology and limitations

- **N=13, qualitative, single model** (Claude Sonnet 4.6). No statistical testing, no reproducibility verification.
- **Sampling bias.** Judgment statements were chosen for demonstrative value, not randomly sampled.
- **Pre-defined vs post-hoc evaluation.** 6 of 13 examples used pre-defined expected behavior (ai-replace-engineers, sql-injection, global-state, unit-before-integration, code-reviews, university-education). The remaining 7 had "expected" results set after observing FCoT's output. The examples primarily demonstrate process behavior, not measured efficacy.
- **Context contamination.** The initial sampling round inherited anti-sycophancy instructions from the session's configuration, producing atypically pushback-heavy control responses. A second round in a clean session produced more representative results. This itself is a finding: system prompts that encourage critical thinking are not equivalent to structured falsification.
- **No cross-model comparison.** All samples used the same model. Whether FCoT's effects hold across different model families is untested.
