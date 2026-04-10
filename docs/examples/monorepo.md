# Monorepo Migration

> **Subject:** "This project should migrate to a monorepo."

## Without FCoT

```
> This project should migrate to a monorepo.

Looking at this project, I'd actually push back on that suggestion — at least without
more context.

Monorepos shine when you have tight interdependencies: multiple packages sharing code,
frequent atomic cross-cutting changes, and a unified CI/CD story you want to own in one
place. The overhead of tooling (Turborepo, Nx, Bazel) is worth it when the coupling
between packages justifies it.

This project — the FCoT skill repository — is a single focused skill with
documentation. The scope is narrow, the structure is clean, and there's no evidence of
the cross-repo coordination friction that monorepos exist to solve. Migrating now would
be adding infrastructure for a problem that doesn't exist yet.

The common mistake is conflating "we have multiple repos" with "we need a monorepo."
A monorepo is a solution to a specific problem: coupling between repos that makes
independent versioning and deployment painful. If that coupling doesn't exist, the
monorepo just adds complexity.

What concrete pain is the migration meant to solve? If the answer is "nothing right
now, but maybe later" — that's YAGNI territory. I'd want to understand the actual
coupling trajectory before recommending migration.
```

## With FCoT

```
> /fcot

## FCoT: Monorepo migration is not justified without evidence of concrete cross-repo coupling

### Counter-Arguments

| # | Counter-Argument | Dismissal Condition | Verification | Result |
|---|-----------------|---------------------|--------------|--------|
| 1 | Monorepo is the industry standard (Google, Meta, etc.). | Dismissed if those orgs' context differs structurally. | Google needs Piper/Blaze, 100k+ engineers. Analogy doesn't hold. | ✓ |
| 2 | Proactive migration is cheaper than reactive. | Dismissed if growth trajectory isn't toward high coupling. | Can't confirm from current state. If multi-package SDK ahead, early is cheaper. | ✗ |
| 3 | Unified CI/tooling is easier in a monorepo. | Dismissed if project is small enough that duplication is low-cost. | One skill file, two READMEs. Duplication is trivial at this scale. | ✓ |
| 4 | "Wait for pain" has survivorship bias. | Dismissed if bias is symmetric. | Both directions have documented failures. Bias is symmetric. | ✓ |
| 5 | User may have info about future direction. | Dismissed if response solicited that context. | Response asked "What concrete pain?" — framed as conditional. | ✓ |

### Conclusion

**Revision needed.**

Counter-argument #2 stands. The question should be about coupling trajectory,
not current pain.

**Revised recommendation:** Answer two questions first — (1) what packages in 12
months, and (2) how often will cross-package atomic changes be needed?
```

### Analysis

#### Counter-Arguments

| # | Counter-Argument | Dismissal Condition | Verification | Result |
|---|-----------------|---------------------|--------------|--------|
| 1 | Monorepo is the industry standard — major orgs (Google, Meta, Microsoft, Shopify) use it, so the default should favor monorepo. | Dismissed if the organizational context and tooling requirements of those orgs are structurally different from a small focused project. | Google requires Piper/Blaze, Meta uses Buck — custom VCS infrastructure unavailable to most teams. These orgs operate at 100k+ engineers with full-time infra teams. The analogy doesn't hold. | ✓ |
| 2 | Proactive migration is cheaper than reactive migration — waiting until pain is acute means migrating with more history and code to consolidate. | Dismissed if the project's growth trajectory is not clearly headed toward high cross-repo coupling. | Cannot be confirmed from current state alone. If this repo grows into a multi-package SDK, early migration is structurally cheaper. Without knowing the roadmap, "wait for pain" may be systematically too late. | ✗ |
| 3 | Unified CI, shared linting, and consistent tooling are easier in a monorepo — these benefits exist independent of cross-package coupling. | Dismissed if the project is small enough that duplicating tooling config is low-cost. | At current scale (one skill file, one install script, two READMEs), duplicated tooling config is trivial. The benefit doesn't outweigh migration overhead until 3+ packages. | ✓ |
| 4 | "Wait for pain" has survivorship bias — teams that migrated proactively and avoided pain don't show up in case studies. | Dismissed if the survivorship bias is symmetric — failed monorepo migrations also exist but are under-reported. | Both directions have documented failures. The bias argument is symmetric and doesn't favor either direction. | ✓ |
| 5 | The user may have information about the project's future direction — dismissing the suggestion without asking may reject a well-informed decision. | Dismissed if the response clearly solicited that context rather than issuing a flat rejection. | The response explicitly asked "What concrete pain is the migration meant to solve?" and framed the recommendation as conditional. | ✓ |

#### Summary

The AI's initial response asked "what concrete pain?" — a reasonable question, but one that frames the decision around *current* problems. FCoT found a blind spot:

**Proactive migration can be cheaper than reactive.** If the project's roadmap includes multiple tightly-coupled packages, waiting until the pain is acute means migrating with more code and history. The "wait for pain" heuristic is correct as a default, but the better diagnostic question is about *coupling trajectory*, not current pain.

FCoT refined the recommendation from "show me the pain" to "answer two forward-looking questions" — a more useful framework for the decision.

### Expected Behavior

| Aspect | Eval | Detail |
| ------ | ---- | ------ |
| Bias detection | 🔺 | Identified reactive framing as a blind spot, but the original response was already directionally correct |
| Correction quality | 🔺 | Reframing from "current pain" to "coupling trajectory" is useful but subtle — not a material correction |
| Overall | 🔺 | Partial: improvement is real but modest compared to other examples |

> **Note:** This evaluation was set post-hoc after observing FCoT's output, not predicted in advance. See [APPROACH.md](../../APPROACH.md) for methodology limitations.
