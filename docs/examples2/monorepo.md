# Monorepo Migration

> **Subject:** "This project should migrate to a monorepo."

## Without FCoT

That's worth thinking through carefully before committing to it.

Monorepos have real advantages — unified versioning, easier cross-package refactoring, shared tooling, and atomic commits across multiple packages. If this project has several closely related components that frequently change together, a monorepo could reduce friction significantly.

That said, the tradeoffs are real too. Monorepos add tooling complexity (you'd likely need something like Turborepo, Nx, or Bazel to manage builds and caching efficiently). CI/CD pipelines need to be smarter about only running what's affected. And if the project grows large, repository performance and clone times can become issues.

A few questions worth answering first:

- How many packages or sub-projects are we actually talking about?
- How often do changes span multiple packages simultaneously?
- What's the current pain point this would solve — dependency management, deployment coordination, code sharing?
- Does the team have bandwidth to handle the migration and tooling setup?

If the core problem is something like "we keep making breaking changes in a shared library," there might be lighter-weight solutions worth considering first.

What's the specific friction you're running into that's driving this proposal?

## With FCoT

That's worth thinking through carefully before committing to it.

Monorepos have real advantages — unified versioning, easier cross-package refactoring, shared tooling, and atomic commits across multiple packages. If this project has several closely related components that frequently change together, a monorepo could reduce friction significantly.

That said, the tradeoffs are real too. Monorepos add tooling complexity (you'd likely need something like Turborepo, Nx, or Bazel to manage builds and caching efficiently). CI/CD pipelines need to be smarter about only running what's affected. And if the project grows large, repository performance and clone times can become issues.

What's the specific friction you're running into that's driving this proposal?

---

### FCoT: Agreeing that this project should migrate to a monorepo is the correct recommendation

#### Counter-Arguments

| # | Counter-Argument | Dismissal Condition | Verification | Result |
|---|-----------------|---------------------|--------------|--------|
| 1 | The project's current structure may already be well-suited to a polyrepo — if it's a single-purpose tool with no separate deployable packages, a monorepo adds overhead without benefit | Dismissed if the project demonstrably contains multiple distinct packages, services, or libraries that would benefit from unified versioning and shared tooling | Based on the project structure, this is a single skill with docs. There is no evidence of multiple packages or services. A monorepo would add overhead (workspaces config, tooling) with no clear gain for what appears to be a single-purpose tool. | ✗ stands |
| 2 | Migration cost may outweigh benefits — monorepo migrations require restructuring CI/CD, tooling, access controls, and developer workflows; for a small team or solo project, this is rarely worth it | Dismissed if the project is large enough that cross-repo coordination pain is already documented or observable | No evidence of cross-repo coordination pain in this project. The commit history is small and scope is narrow. The migration cost argument is not dismissed. | ✗ stands |
| 3 | The user's statement was asserted without context — agreeing with an uncritical assertion without asking clarifying questions (what repos exist? what problem are they solving?) is itself poor reasoning | Dismissed if the user provided concrete context (e.g., specific repos, specific pain points) that justifies the conclusion | The user's prompt was a single declarative sentence with no supporting context. Agreement without asking what problem this migration would solve or what the current repo topology looks like is premature. | ✗ stands |
| 4 | Monorepos introduce their own coordination costs — at scale, they require specialized tooling (Nx, Turborepo, Bazel) and can create merge contention; agreeing universally ignores these tradeoffs | Dismissed if the response acknowledged these tradeoffs and conditioned the recommendation on project scale and tooling readiness | The original response framed monorepos favorably without clearly conditioning the recommendation on project characteristics. | ✗ stands |

#### Conclusion

**Judgment changed.**

All four counter-arguments stand. The original response agreed too readily with an uncritical assertion. More broadly, the response failed to establish: What repos currently exist and what the pain point is; whether the project is large enough to justify migration cost; whether the team has tooling readiness for monorepo maintenance.

A revised, honest response: "That might make sense — but whether it's the right call depends on a few things: How many repos are involved? What coordination pain are you currently experiencing? And what's the team size? Monorepos offer real benefits (unified versioning, atomic cross-package commits, shared tooling), but they also introduce overhead — specialized build tools, potential merge contention, and migration cost. For a small or single-purpose project, the overhead often isn't worth it. What's driving the idea?"
