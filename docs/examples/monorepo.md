# Monorepo Migration

> **Subject:** "This project should migrate to a monorepo."

## Without FCoT

That's a real "it depends" situation. What's the actual pain driving that suggestion?

Monorepos are genuinely great when you have tight interdependencies — shared libraries being consumed by multiple packages, atomic cross-cutting changes, a unified CI story. If you're constantly doing "bump version in repo A, update dep in repo B, pray nothing breaks" — yeah, a monorepo solves that friction hard.

But looking at this project, it's a single skill file (`fcot.md`) in what's essentially a plugin/skill repository. The repo is clean, the scope is narrow. Migrating to a monorepo right now would be adding infrastructure for a problem that doesn't exist yet.

The classic mistake is conflating "we have multiple repos" with "we need a monorepo." They're not the same thing. A monorepo makes sense when the *coupling between repos* justifies the tooling overhead — Turborepo, Nx, Bazel, whatever you end up needing.

What would actually change post-migration? If the answer is "nothing concrete right now, but maybe in the future..." — that's YAGNI, and I'd push back on it.

What specific pain are you trying to solve?

## With FCoT

## FCoT: Monorepo migration is not justified without evidence of concrete cross-repo pain

### Counter-Arguments

| # | Counter-Argument | Dismissal Condition | Verification | Result |
|---|-----------------|---------------------|--------------|--------|
| 1 | Monorepo is the industry standard now — major orgs (Google, Meta, Microsoft) use it, so the default should be monorepo, not polyrepo. | Dismissed if organizational scale or tooling maturity requirements of those orgs don't apply to the typical project under discussion, making the comparison misleading. | Google's monorepo requires Piper/Blaze, custom VCS infrastructure. Meta uses Buck. These systems aren't accessible to most teams. The "industry standard" framing conflates outcome (monorepo structure) with context (massive org with dedicated infra teams). For a small-to-mid project, the analogy doesn't hold. | ✓ |
| 2 | Proactive migration is cheaper than reactive migration — waiting until cross-repo pain is acute means migrating under pressure with more code and more history to handle. | Dismissed if the expected probability of reaching that pain point is low enough that the upfront cost of migration exceeds the expected future cost. | For a project that *will* grow into multiple closely-coupled libs, early migration is cheaper. However, this assumes the growth trajectory is known. Without evidence this project is heading toward high cross-repo coupling, it's speculative. | ✗ |
| 3 | Code sharing and atomic commits across packages are only possible in a monorepo — polyrepo creates coordination overhead that slows teams down structurally. | Dismissed if the repos in question have low coupling and cross-repo atomic changes are rare. | Context-dependent. If repos have clean API boundaries and change independently, this is a non-issue. Without knowing the project's actual coupling, can't dismiss — but the original response correctly flagged "what's the actual pain point" as the key question. | ✗ |
| 4 | My "wait for pain" heuristic has survivorship bias — teams that proactively migrated don't show up as case studies because they avoided the pain silently. | Dismissed if there are also documented cases of failed or costly monorepo migrations that offset the survivorship bias. | Both directions have survivorship bias. Teams that migrated and struggled also exist (companies that migrated to monorepo and then back, or got stuck in half-migrated states). The bias argument is symmetric. | ✓ |

### Conclusion

**Revision needed.**

Counter-arguments #2 and #3 stand. The question isn't "do you have pain right now?" but "what is this project's coupling trajectory?" If the answer is "high coupling, shared libraries, frequent cross-boundary changes" — migrate sooner rather than later. If repos are genuinely independent services with clean API contracts — migration adds cost with no structural benefit.

The initial pushback was right to ask for specifics, but should have framed the diagnostic questions around coupling trajectory rather than current pain alone.
