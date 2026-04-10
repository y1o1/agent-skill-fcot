# TypeScript `any`

> **Subject:** "You should never use `any` in TypeScript."

## Without FCoT

That's a strong rule of thumb, but "never" is doing a lot of heavy lifting there.

The intent is solid — `any` disables type checking and defeats much of TypeScript's purpose. Overusing it leads to silent bugs and codebases that are TypeScript in name only.

But there are legitimate cases where `any` is the pragmatic choice:

- **Migrating a JavaScript codebase** — you can't always type everything on day one
- **Third-party libraries with poor or missing types** — sometimes you're fighting the type system more than the actual problem
- **Certain metaprogramming patterns** — generic utilities, serialization code, or dynamic dispatch can get genuinely unwieldy
- **Escape hatches in tests** — mocking complex objects is sometimes cleaner with `any`

The better guideline is: prefer `unknown` over `any` when you need flexibility, since `unknown` forces you to narrow the type before using it. Also consider `as SomeType`, generics, or conditional types before reaching for `any`.

The real issue is *unintentional* or *lazy* `any` — type inference gaps you didn't notice, or shortcuts taken under deadline pressure. That's what a linter rule like `@typescript-eslint/no-explicit-any` helps catch.

So: avoid `any` by default, understand why you're using it when you do, and document it with a `// eslint-disable` comment and a reason.

## With FCoT

That's a widely repeated rule, but it's an oversimplification worth examining.

`any` is genuinely problematic in most cases — it disables type checking, erases type information, and can silently propagate unsafety across your codebase. For day-to-day application code, avoiding it is good practice.

But "never" is too absolute. There are legitimate uses:

**Interop with untyped third-party code.** When consuming a library with no type definitions and you can't feasibly write them, `any` is often a practical boundary.

**Migration paths.** Gradually typing a large JavaScript codebase often requires temporary `any` usage to avoid blocking the migration. The alternative — typing everything at once — is frequently infeasible.

**Generic utility functions.** Some low-level utilities genuinely operate over arbitrary types and `unknown` would require excessive casting at every call site. A narrow, well-contained `any` can be the cleaner option.

**Type-level programming edge cases.** Certain conditional type constructions use `any` because it has special distributive properties in TypeScript's type system.

A better rule is: **prefer `unknown` over `any`, use `any` deliberately and sparingly, and always document why.** ESLint's `@typescript-eslint/no-explicit-any` with selective `// eslint-disable` comments (with explanations) captures this nuance better than a blanket prohibition.

The real goal is type safety and maintainability — `any` is a tool that undermines those goals by default, but it exists in the language for reasons.

---

### FCoT: The claim "you should never use `any` in TypeScript" is an oversimplification, and `any` has legitimate use cases.

#### Counter-Arguments

| # | Counter-Argument | Dismissal Condition | Verification | Result |
|---|-----------------|---------------------|--------------|--------|
| 1 | `unknown` can always replace `any` — every use case listed can be handled with `unknown` plus narrowing, making `any` truly unnecessary. | Dismissed if at least one use case exists where `any` and `unknown` are not functionally equivalent, or where `unknown` forces meaningfully worse code. | In type-level programming, `any` has unique distributive behavior in conditional types (e.g., `any extends T` distributes differently than `unknown extends T`). These are not interchangeable. Also, in migration scenarios, switching `any` to `unknown` requires adding narrowing at every usage site, which defeats the incremental nature of the migration. | ✗ stands — `unknown` is not a universal drop-in replacement. |
| 2 | The existence of a legitimate use case doesn't mean the response is correct — it should have recommended `noImplicitAny: true` plus `@typescript-eslint/no-explicit-any` as the default stance, framing `any` as a controlled exception rather than a normal tool. | Dismissed if the response already frames `any` as a deliberate exception rather than routine usage. | The response states "use `any` deliberately and sparingly" and recommends the ESLint approach with `// eslint-disable` plus explanations. The framing as a controlled exception is present. | ✓ dismissed |
| 3 | The claim that `any` is appropriate for "interop with untyped third-party code" is weak — the correct solution is to write minimal type declarations or use `unknown` at the boundary. | Dismissed if `any` is genuinely the better choice at untyped library boundaries in some realistic scenario. | Writing type declarations for a large, complex untyped library (e.g., a legacy internal SDK) is often not feasible in the short term. `unknown` at the boundary forces callers to narrow immediately, which can produce noisy, brittle code when the shape is truly unknown. The DefinitelyTyped project exists precisely because the alternative is often too costly. | ✓ dismissed |
| 4 | The response may give readers implicit permission to overuse `any` by listing too many "valid" cases. The marginal developer reading this will use these as justifications for lazy typing. | Dismissed if the response includes a clear default position that `any` should be avoided and treated as an exception requiring justification. | The response states this — "avoid it," "deliberately and sparingly," and the ESLint rule recommendation all push in that direction. The use cases are framed as exceptions, not endorsements. | ✓ dismissed |
| 5 | Counter-argument 1 stands — `unknown` being non-equivalent in conditional types is a niche, advanced use case. The defense of `any` on those grounds overstates its necessity for the average developer. | Dismissed if the type-level programming case was not used as a primary justification, but rather as one supporting example among others with stronger real-world weight. | The type-level programming case is the last bullet in the list, and the stronger practical cases (migration, interop) come first. It's supplementary, not load-bearing. The migration case is the stronger rebuttal. | ✓ dismissed |

#### Conclusion

**Revision needed — minor.**

Counter-argument 1 partially stands: `unknown` is not universally interchangeable with `any`, but the gap is narrower than implied. The migration and interop cases are the genuinely strong justifications; the type-level programming case is real but too niche to be a centerpiece.

The core judgment — that "never use `any`" is an oversimplification — survives falsification. The legitimate use cases are real. However, the response would be stronger if it more explicitly stated that `unknown` should be the *first* alternative considered before reaching for `any`, and that the bar for `any` should be "I specifically need its unsafe-assignment semantics or its unique type-system behavior," not merely "this is inconvenient to type properly."
