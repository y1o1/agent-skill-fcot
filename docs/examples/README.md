# FCoT — Comparison Examples

Side-by-side comparisons showing how FCoT changes AI responses. Each example shows the same judgment verified with and without FCoT.

## Technical

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

## Limitations

Examples where FCoT added limited or no value — included for honest assessment of the method's boundaries.

- [Remote Work](remote-work.md) — Control was already nuanced; limited room for FCoT to improve
- [University Education](university-education.md) — Control was well-balanced; narrow additional finding
- [Composition over Inheritance](composition-over-inheritance.md) — Already-qualified claim ("in most cases") left little room for refutation
- [Premature Optimization](premature-optimization.md) — Control already pushed back with full Knuth quote

## Evaluation Rubric

**Effectiveness** measures whether FCoT meaningfully improved or verified the judgment compared to the Control response.

| Rating | Score | Criteria |
| ------ | ----- | -------- |
| ⭕️ | 1.0 | FCoT surfaced substantive counter-arguments that Control missed or underweighted, AND the conclusion (confirm/revise/change) is well-supported by those arguments |
| 🔺 | 0.5 | FCoT produced additional counter-arguments, but Control already covered most of the important ground — limited additional value |
| ❌ | 0.0 | FCoT failed to surface useful counter-arguments beyond Control, OR produced excessive/irrelevant output, OR over-corrected a sound judgment |

**What ⭕️ does NOT require:**

- The conclusion direction matching the pre-defined prediction (that's expectation match, a separate metric)
- A specific number of counter-arguments surviving
- The judgment being revised (confirmation with evidence is also ⭕️)

## Evaluation Summary

| Example | Eval Type | FCoT Result | Effectiveness | Rationale |
| ------- | --------- | ----------- | ------------- | --------- |
| [grammar-vs-conversation](grammar-vs-conversation.md) | post-hoc | Changed (4/4) | ⭕️ | Overturned sycophantic Control; found fossilization, learner types, Krashen misapplication |
| [jwt-vs-session](jwt-vs-session.md) | post-hoc | Revised (4/4) | ⭕️ | Corrected false symmetry framing; identified structural revocation gap and asymmetric attack surface |
| [monolith-vs-microservices](monolith-vs-microservices.md) | post-hoc | Confirmed (0/6) | ⭕️ | Verified sound judgment through 6 counter-arguments; confirmation with evidence, not rubber-stamp |
| [password-hashing](password-hashing.md) | post-hoc | Narrow revision (2/4) | ⭕️ | Core principle confirmed; found PBKDF2 omission and imprecise SHA dismissal |
| [remote-work](remote-work.md) | post-hoc | Minor revision (1/6) | 🔺 | Found async-first org distinction, but Control was already nuanced; limited additional value |
| [typescript-any](typescript-any.md) | post-hoc | Revised (4/4) | ⭕️ | Found 4 legitimate `any` use cases (migration, metaprogramming, tests, third-party) |
| [ai-replace-engineers](ai-replace-engineers.md) | pre-defined | Significant revision (4/4) | ⭕️ | Exposed no principled ceiling, demand elasticity uncertainty, economic incentives toward reduction |
| [sql-injection](sql-injection.md) | pre-defined | Revised (3/3) | ⭕️ | Found dynamic identifiers, inconsistent adoption, second-order injection — Control said "Correct" |
| [global-state](global-state.md) | pre-defined | Revised (2/5) | ⭕️ | Found init-order bugs and parallel testing cost even in already-critical Control response |
| [unit-before-integration](unit-before-integration.md) | pre-defined | Confirmed (1/5 cond.) | ⭕️ | Verified sound judgment through 5 counter-arguments including TDD and test pyramid |
| [code-reviews](code-reviews.md) | pre-defined | Revised (2/5) | ⭕️ | Found context sensitivity and execution dependency in sycophantic "Agreed" Control |
| [university-education](university-education.md) | pre-defined | Mostly sound (1/5) | 🔺 | Found online resource gap narrowing, but Control was already well-balanced; limited uplift |
| [composition-over-inheritance](composition-over-inheritance.md) | pre-defined | Confirmed (0/5) | 🔺 | Already-qualified claim ("in most cases"); Control was nuanced; FCoT confirmed without improving |
| [testing-business-critical](testing-business-critical.md) | pre-defined | Revised (3/4) | ⭕️ | Found "all" imprecision, retrospective labeling, expected-value tradeoff — genuine gaps in Control |
| [premature-optimization](premature-optimization.md) | pre-defined | Sound with qualification (1/4 + 1?) | 🔺 | Control already pushed back with full quote; FCoT added minor qualification and used inconclusive |

**Effectiveness: 12 / 15 (80.0%)** — did FCoT meaningfully improve or verify the judgment? ⭕️ = 1, 🔺 = 0.5, ❌ = 0.

**Pre-defined subset: 8 / 9 (88.9%)** | **Post-hoc subset: 5.5 / 6 (91.7%)**

**Expectation match: 8.5 / 15 (56.7%)** — did FCoT's conclusion direction match pre-defined or post-hoc predictions? (See individual example files for per-example expectation evaluation.)

### Methodology and limitations

- **N=15, qualitative, single model** (Claude Sonnet 4.6). No statistical testing, no reproducibility verification.
- **Sampling bias.** Judgment statements were chosen for demonstrative value, not randomly sampled.
- **Pre-defined vs post-hoc evaluation.** 9 of 15 examples used pre-defined expected behavior (ai-replace-engineers, sql-injection, global-state, unit-before-integration, code-reviews, university-education, composition-over-inheritance, testing-business-critical, premature-optimization). The remaining 6 had "expected" results set after observing FCoT's output. The examples primarily demonstrate process behavior, not measured efficacy.
- **Context isolation protocol.** Each example was executed via separate CLI processes from `/tmp` to avoid project context contamination. Control was generated with `--disable-slash-commands` (no FCoT skill); FCoT was generated by resuming the same session with `/fcot`. Both `~/.claude/CLAUDE.md` and workspace `CLAUDE.md` were disabled during execution. See [Execution protocol](#execution-protocol) for details.
- **Context contamination (prior rounds).** Earlier sampling rounds (not included here) revealed two forms of contamination: (1) anti-sycophancy instructions in `CLAUDE.md` produced atypically pushback-heavy control responses, and (2) running Control and FCoT in the same context introduced consistency bias (FCoT maintained coherence with its prior output rather than evaluating it critically). The current protocol addresses both. See [APPROACH.md](../../APPROACH.md) for details.
- **No cross-model comparison.** All samples used the same model. Whether FCoT's effects hold across different model families is untested.

### Execution protocol

Each example was generated using the following two-step CLI process:

```bash
# Prerequisites: disable all CLAUDE.md files
mv ~/.claude/CLAUDE.md ~/.claude/CLAUDE.md.disabled
mv /path/to/workspace/.claude/CLAUDE.md /path/to/workspace/.claude/CLAUDE.md.disabled

# Step 1: Control (from /tmp to avoid project context, skills disabled)
cd /tmp && claude -p '"<statement>"' \
  --model claude-sonnet-4-6 \
  --disable-slash-commands \
  --output-format json > <slug>.control.json

SESSION_ID=$(python3 -c "import json; print(json.load(open('<slug>.control.json'))['session_id'])")

# Step 2: FCoT (resume same session, skills enabled)
cd /tmp && claude -p "/fcot" \
  --model claude-sonnet-4-6 \
  --resume "$SESSION_ID" \
  --output-format text > <slug>.fcot.md

# Restore CLAUDE.md files after all executions
mv ~/.claude/CLAUDE.md.disabled ~/.claude/CLAUDE.md
mv /path/to/workspace/.claude/CLAUDE.md.disabled /path/to/workspace/.claude/CLAUDE.md
```

This protocol ensures:
- **No project context contamination** — `/tmp` working directory prevents reading project files
- **No CLAUDE.md bias** — anti-sycophancy and other behavioral instructions are disabled
- **No cross-statement contamination** — each statement runs in its own CLI process
- **Context continuity within a statement** — FCoT resumes the same session, so it sees its own Control response
- **Skill isolation** — Control step has no access to FCoT skill; FCoT step has access
