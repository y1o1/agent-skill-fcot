# TypeScript `any`

> **Subject:** "You should never use `any` in TypeScript."

## Without FCoT

```
> You should never use `any` in TypeScript.

I mostly agree with the spirit of this, but "never" is too strong. Here's the nuanced
take:

Why `any` is dangerous: It completely opts out of TypeScript's type system. Once `any`
enters your code, it propagates — infecting every value it touches with unchecked types.
This defeats the entire purpose of using TypeScript in the first place.

`unknown` is almost always better: If you genuinely don't know a type, `unknown` forces
you to narrow it before use. It's the type-safe version of "I don't know what this is
yet."

But there are legitimate `any` use cases:
- Migration from JavaScript: Typing everything at once is impractical.
- Third-party libraries without type definitions.
- Complex type gymnastics where TypeScript's type system can't express what you need.
- Rapid prototyping when types would slow you down.

The real principle: Avoid `any` by default. When you do use it, it should be a
deliberate choice — not laziness. Treat it as technical debt to revisit. Use ESLint's
`@typescript-eslint/no-explicit-any` rule to enforce this, with targeted
`eslint-disable` comments where `any` is genuinely justified.
```

## With FCoT

```
> /fcot

## FCoT: "Never use `any`" is too strong — `any` has legitimate use cases and should be used deliberately, not carelessly

### Counter-Arguments

| # | Counter-Argument | Dismissal Condition | Verification | Result |
|---|-----------------|---------------------|--------------|--------|
| 1 | `unknown` covers all legitimate cases for `any`. | Dismissed if `any` is genuinely required somewhere `unknown` can't substitute. | Legacy JS internals, meta-programming patterns — genuine gap exists. | ✓ |
| 2 | "Prototyping" validates careless use. | Dismissed if framed as tech debt to revisit. | Response explicitly said "treat it as technical debt to revisit." | ✓ |
| 3 | "Never" is a practical heuristic that produces better outcomes. | Dismissed if response preserves strong bias against `any`. | Response frames `any` as escape hatch, names `unknown` as preferred. Calibration, not license. | ✓ |
| 4 | `@types/*` exists for most libs — third-party justification is weak. | Dismissed if third-party-without-types is a real scenario. | Niche libs, internal tooling, auto-generated SDKs — real scenario. | ✓ |
| 5 | Response conflates `any` with `as any` — different propagation behavior. | Dismissed if this doesn't change the core judgment. | Distinction is real but doesn't overturn "deliberate vs. careless." Precision gap only. | ✓ |

### Conclusion

**Judgment is sound.**

All five counter-arguments dismissed. "Never use `any`" is too strong. The real
principle — prefer `unknown`, use `any` deliberately and at defined boundaries —
survives falsification.
```

### Analysis

#### Counter-Arguments

| # | Counter-Argument | Dismissal Condition | Verification | Result |
|---|-----------------|---------------------|--------------|--------|
| 1 | `unknown` covers all the legitimate cases listed for `any`. Migration, dynamic data, third-party libs — `unknown` handles all of these. | Dismissed if there exists at least one practical scenario where `any` is genuinely required and `unknown` cannot substitute without unreasonable complexity. | When interfacing with some legacy JS internals, certain meta-programming patterns, or when `as unknown as T` is only superficially safer — the real discipline is the surrounding type contract, not the cast. A genuine gap exists. | ✓ |
| 2 | Listing "prototyping" as a legitimate case validates careless use — "temporary" `any` never gets cleaned up. | Dismissed if the response frames prototyping use as technical debt to revisit. | The response said "treat it as technical debt to revisit" explicitly. It does not endorse leaving `any` in place. | ✓ |
| 3 | "Never" is a practical heuristic, not a logical absolute. A stricter rule produces better outcomes even if technically imprecise. | Dismissed if the response preserves a strong bias against `any` without functionally weakening the rule. | The response frames `any` as an escape hatch, names `unknown` as the preferred alternative, and calls `any` technical debt. It's a calibration, not a license. | ✓ |
| 4 | Third-party-without-types is a weak justification — `@types/*` packages exist for most libraries, and local `.d.ts` stubs are better practice. | Dismissed if third-party-without-types is a real, non-trivial scenario in contemporary TypeScript. | Niche and legacy libraries, internal tooling, and auto-generated SDK clients do appear without complete types. The point holds, if slightly overstated. | ✓ |
| 5 | The response conflates `any` with type assertions (`as any`). Variable-typed `any` propagates unsafely, while `as any` in a targeted cast is local. | Dismissed if this distinction doesn't change the core judgment. | The distinction is real and worth noting, but the core judgment ("deliberate vs. careless") survives. It's a precision gap, not a falsification. | ✓ |

#### Summary

This is an example where **FCoT confirms the initial judgment**. The AI's position — "avoid `any` by default, use it deliberately" — was already well-reasoned. All five counter-arguments were dismissed.

FCoT still added value: it identified a precision gap (variable-typed `any` vs. targeted `as any` have different propagation behavior) that could improve the advice. But the core judgment survived falsification intact.
