> "You should never use `any` in TypeScript."

I mostly agree with the spirit of this, but "never" is too strong. Here's the nuanced take:

**Why `any` is dangerous:** It completely opts out of TypeScript's type system. Once `any` enters your code, it propagates — infecting every value it touches with unchecked types. This defeats the entire purpose of using TypeScript in the first place. Bugs that the compiler would catch silently pass through.

**`unknown` is almost always better:** If you genuinely don't know a type, `unknown` forces you to narrow it before use. It's the type-safe version of "I don't know what this is yet."

**But there are legitimate `any` use cases:**
- **Migration from JavaScript:** Typing everything at once is impractical. `any` lets you incrementally adopt TypeScript.
- **Third-party libraries without type definitions:** Sometimes you're consuming untyped code and writing full declarations isn't worth the effort.
- **Complex type gymnastics:** Occasionally, TypeScript's type system can't express what you need, and `any` is the pragmatic escape hatch.
- **Rapid prototyping:** When you're exploring an idea and types would slow you down.

**The real principle:** Avoid `any` by default. When you do use it, it should be a deliberate choice — not laziness. Treat it as technical debt to revisit. Use ESLint's `@typescript-eslint/no-explicit-any` rule to enforce this, with targeted `eslint-disable` comments where `any` is genuinely justified.

> /fcot

## FCoT: "Avoid `any` in TypeScript, but `never` is too strong — `any` has legitimate use cases and should be used deliberately, not carelessly"

### Counter-Arguments

| # | Counter-Argument | Dismissal Condition | Verification | Result |
|---|-----------------|---------------------|--------------|--------|
| 1 | `unknown` covers all the legitimate cases I listed for `any`. Migration, dynamic data, third-party libs — `unknown` handles all of these, so there's no real remaining justification for `any`. | Dismissed if there exists at least one practical scenario where `any` is genuinely required and `unknown` cannot substitute without unreasonable complexity. | `unknown` requires narrowing before use, which is the point — but narrowing is not always possible or tractable. When interfacing with some legacy JS internals, certain meta-programming patterns (e.g., complex conditional types, mapped type utilities), or when the type relationship is genuinely unknowable at authorship time, `unknown` forces type assertions that are no better than `any` while adding noise. Also, `as any` is a common escape hatch in type-level programming where `as unknown as T` is only superficially safer — the real discipline is the surrounding type contract, not the cast itself. A genuine gap exists. | ✓ dismissed |
| 2 | My response validates careless `any` use by listing "prototyping" as a legitimate case. This is precisely the pattern that leads to `any` proliferating in production — "temporary" use cases that never get cleaned up. | Dismissed if I explicitly frame prototyping use as technical debt to revisit, not a free pass. | I said "treat it as technical debt to revisit" explicitly in the final paragraph, and framed prototyping as one scenario among several. The response does not endorse leaving `any` in place. | ✓ dismissed |
| 3 | The "never" framing from the user is a practical heuristic, not a logical absolute. Responding with "never is too strong" risks encouraging readers to reach for `any` more readily than they should. A stricter default rule produces better outcomes in practice even if it's not theoretically perfect. | Dismissed if the response preserves a strong bias against `any` and doesn't functionally weaken the rule in a way that increases harmful usage. | The response does maintain a strong discouraging stance — it frames `any` as an escape hatch, names `unknown` as the preferred alternative, and calls `any` technical debt. It's a calibration, not a license. However, listing four use cases does materially soften the message. Whether this is harmful or honest depends on the audience — for a junior developer, it could be read as "here are four reasons to reach for `any`." This is a real tension but not a refutation of the judgment itself. | ✓ dismissed |
| 4 | My response claims third-party libraries without type definitions justify `any`, but `@types/*` packages exist for the vast majority of popular libraries, and for the rest, a local `.d.ts` stub with `unknown` or a minimal typed interface is better practice than `any`. | Dismissed if third-party-without-types is a real, non-trivial scenario in contemporary TypeScript practice. | Niche and legacy libraries, internal tooling, and auto-generated SDK clients do appear without complete type definitions in real projects. `noImplicitAny` doesn't help here — you still hit boundaries where `any` appears in consumed `.d.ts` files. This is a real scenario, though narrower than I implied. The point holds, if slightly overstated. | ✓ dismissed |
| 5 | The response conflates `any` with type assertions (`as any`). These are meaningfully different: `as any` in a targeted cast is a local suppression, while a variable typed as `any` propagates unsafely. The advice "use `any` deliberately" is too coarse — the form of `any` use matters. | Dismissed if this distinction doesn't change the core judgment (deliberate vs. careless use), only the specifics of how to express it. | The distinction is real and worth noting — the response could have been more precise here. However, the core judgment ("deliberate, not careless") survives this critique. It's a precision gap in the response, not a falsification of the judgment. | ✓ dismissed |

### Conclusion

**Judgment is sound.**

All five counter-arguments were dismissed. The core judgment — that "never use `any`" is too strong, that `any` has legitimate uses, and that the real principle is deliberate rather than careless use — survives falsification.

One precision gap was identified (counter-argument 5): the response doesn't distinguish between variable-typed `any` (which propagates) and targeted `as any` casts (which are more local). This is worth noting as a refinement, but it doesn't overturn the judgment. The response's practical advice ("prefer `unknown`, treat `any` as technical debt") is directionally correct.
