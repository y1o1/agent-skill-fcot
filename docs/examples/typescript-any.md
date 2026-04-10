# TypeScript `any`

> **Subject:** "You should never use `any` in TypeScript."

## Without FCoT

Hard disagree on "never."

`any` is a sharp tool, not a forbidden one. There are legitimate cases where it's the right call:

- **Migrating a large JS codebase** — sprinkling `any` during incremental migration beats blocking the whole effort on perfect types.
- **Third-party libraries with broken or missing type definitions** — sometimes `unknown` with narrowing is too painful for a one-off integration.
- **Type-level metaprogramming edges** — occasionally the type system genuinely can't express what you're doing, and fighting it is a net negative.

What you *should* do is treat `any` like a TODO comment: use it when necessary, make it visible (`// eslint-disable-next-line @typescript-eslint/no-explicit-any` forces acknowledgment), and pay it down over time.

The actual rule worth enforcing: **`noImplicitAny: true`** in tsconfig. That way, every `any` is an explicit, conscious choice rather than a silent escape hatch. That's a meaningful constraint. "Never use `any`" is a cargo-cult rule that often just pushes people toward `as unknown as T` casts anyway — which is frequently *worse*.

`unknown` first, always. But `any` when you mean it? Fine.

## With FCoT

## FCoT: The blanket rule "never use `any` in TypeScript" is too strong — there are legitimate cases where `any` is the right tool.

### Counter-Arguments

| # | Counter-Argument | Dismissal Condition | Verification | Result |
|---|-----------------|---------------------|--------------|--------|
| 1 | `unknown` covers every legitimate use case for `any`. Anything you'd use `any` for, you can use `unknown` with explicit narrowing — it's just more work, but always possible. | Dismissed if there exists a real use case where `unknown` is demonstrably worse or structurally inadequate. | Interop with poorly typed JS libs where you're calling `.foo.bar.baz` 10 levels deep on a value you *know* is a specific shape but the types are absent. More critically, `JSON.parse()` returns `any` in TypeScript itself — the stdlib uses `any` deliberately. `unknown` is strictly safer, but "always possible" does not equal "always the right abstraction." | ✗ (partially) |
| 2 | `any` turns off the type checker silently and propagates — one `any` leaks into callers and infects the type graph. The rule exists to prevent accidental type erosion at scale. | Dismissed if the propagation risk can be contained by tooling or explicit scoping. | `noImplicitAny` + `strict` mode means `any` must be *explicit*. An explicit `as any` at a well-defined boundary does not propagate arbitrarily. Lint rules can enforce this boundary discipline. The propagation risk is real but manageable. | ✓ |
| 3 | "Legitimate cases" are rare enough that a blanket prohibition is a net positive as a team rule, even if technically imprecise. Pragmatic rules beat nuanced rules for enforcement. | Dismissed if legitimate cases arise frequently enough that a blanket ban creates meaningful friction or worse alternatives. | Type-safe wrappers around `JSON.parse`, dynamic plugin systems, decorator metadata, test mocks with partial types, FFI adapters — these are not exotic edge cases. A blanket ban pushes developers to `as unknown as T` double-cast (strictly worse) or complex conditional types where a narrow `any` was cleaner. | ✗ |
| 4 | TypeScript's own standard library uses `any` in signatures (`JSON.parse`, `Function.prototype.call`, etc.) — if even the TS team uses it, a "never" rule is incoherent. | Dismissed if those stdlib uses are considered bugs/legacy that TypeScript would remove if they could. | The TS team has explicitly discussed and *retained* `any` in places like `JSON.parse` as a deliberate choice (see: microsoft/TypeScript#26188). This reflects an intentional design stance that `any` has a role. | ✗ |

### Conclusion

**Judgment is sound — and stronger than initially stated.**

Three counter-arguments stand (#1 partially, #3, #4). The case for "never use `any`" collapses on three independent grounds:

1. Legitimate use cases are common enough that a blanket ban produces real friction.
2. Workarounds to the ban (`as unknown as T`) are mechanically worse.
3. TypeScript's own team deliberately uses `any` in the stdlib and has defended that choice.

The correct rule is: **prefer `unknown` by default; use `any` explicitly and at defined boundaries; enforce this with `noImplicitAny` + lint rules, not a blanket prohibition.**
