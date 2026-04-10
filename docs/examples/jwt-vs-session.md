# JWT vs Session Auth

> **Subject:** "Session-based auth is more secure than JWT."

## Without FCoT

```
> Session-based auth is more secure than JWT.

That's a common claim, and there's real truth behind it — but it's not the whole
picture.

Session-based auth stores session state server-side. The server controls session
lifecycle, so revoking a session is immediate and certain. If a user logs out or gets
compromised, you invalidate the session and it's done. That's a genuine security
advantage.

JWTs, by contrast, are stateless. Once issued, they're valid until expiry — you can't
"recall" them without adding server-side state (like a token blocklist), which partially
defeats the stateless design. If a JWT is stolen, the attacker has access until it
expires.

That said, "more secure" is context-dependent. Session-based auth has its own
vulnerabilities: CSRF attacks are a classic concern, server-side session stores become
attack surfaces, and scaling across distributed systems introduces complexity that can
itself create security gaps.

JWTs, when implemented correctly — short expiry, rotation, HTTPS-only, proper signature
validation — can be equally secure for many use cases. The security delta often comes
down to implementation quality rather than the mechanism itself.

The strongest claim you can make is: session-based auth makes revocation simpler, which
reduces the blast radius of a compromised credential. But calling it categorically
"more secure" oversimplifies a tradeoff that depends heavily on your threat model,
infrastructure, and implementation discipline.
```

## With FCoT

```
> /fcot

## FCoT: Session-based auth is not categorically more secure than JWT — security depends on context, threat model, and implementation.

### Counter-Arguments

| # | Counter-Argument | Dismissal Condition | Verification | Result |
|---|-----------------|---------------------|--------------|--------|
| 1 | Revocation advantage is real and decisive for high-security contexts. | Dismissed if JWT can match revocation without adding state. | JWTs cannot match immediate revocation without a blocklist. Gap is structural. | ✓ |
| 2 | CSRF is largely solved with modern SameSite cookies. | Dismissed if CSRF is genuinely mitigated by default. | SameSite attributes largely neutralize CSRF. Overstated as counterweight. | ✗ |
| 3 | JWT misimplementation is systematically more common and dangerous. | Dismissed if not systematically more common. | OWASP cites JWT-specific vulns as prevalent. More moving parts to misconfigure. | ✗ |
| 4 | Scaling concerns for sessions are overstated. | Dismissed if scaling doesn't add real security complexity. | Redis/sticky sessions are mature. Risk is operational, not fundamental. | ✗ |

### Conclusion

**Revision needed.**

Three counter-arguments stand. CSRF was overstated, JWT misimplementation risk was
underweighted, and scaling complexity is operational not security-related.

**Revised position:** Session auth is the safer default; JWT is justified when
stateless distribution is architecturally required and the team can implement it
correctly.
```

### Analysis

#### Counter-Arguments

| # | Counter-Argument | Dismissal Condition | Verification | Result |
|---|-----------------|---------------------|--------------|--------|
| 1 | Session-based auth's revocation advantage is real and decisive — you cannot revoke a JWT without adding state, making JWT structurally weaker for high-security contexts (financial, medical). The initial response downplays this. | Dismissed if JWT can match session revocation without sacrificing stateless properties, or if the gap is only decisive in narrow use cases. | JWTs cannot match immediate revocation without a blocklist. Short-lived JWTs narrow the window but don't close it. In high-security contexts, the revocation gap *is* decisive. The initial response acknowledged this implicitly but could have been clearer. | ✓ |
| 2 | CSRF is largely a solved problem with modern SameSite cookie attributes — the initial response overstated it as a counterweight to session-based security. | Dismissed if CSRF is genuinely mitigated by default in modern implementations. | SameSite=Strict/Lax cookie attributes largely neutralize CSRF in modern browsers. Treating CSRF as an equivalent structural flaw to JWT revocation is not accurate. | ✗ |
| 3 | "Implementation quality equalizes the two" overgeneralizes. JWT misimplementation (weak secrets, long expiry, no rotation) is systematically more common and dangerous than equivalent session auth misimplementation. | Dismissed if JWT misimplementation is not systematically more common or dangerous. | JWT's flexibility (algorithm choice, expiry settings, claim validation) creates more attack surface for developer error. OWASP consistently cites JWT-specific misimplementation as a prevalent vulnerability category. Session auth has fewer moving parts to misconfigure. | ✗ |
| 4 | Distributed/scaling concerns for session auth are overstated — sticky sessions and Redis-backed session stores are mature, standard solutions. | Dismissed if scaling session auth does not introduce security complexity beyond what standard tooling addresses. | Sticky sessions and centralized session stores are mature and widely used. The security risk is largely operational rather than fundamental. The initial response implied more security risk than is accurate. | ✗ |

#### Summary

The AI's initial response presented JWT and session auth as roughly equivalent — "the security delta comes down to implementation quality." FCoT found three flaws in this framing:

1. **CSRF was overstated** as a session-auth weakness. Modern SameSite cookies largely solve it — it's not a fair counterweight to JWT's revocation gap.
2. **JWT misimplementation risk is asymmetric.** JWT has more moving parts (algorithm choice, expiry, claim validation) and is empirically harder to implement safely.
3. **Scaling concerns were misframed** as a security issue when they're operational.

FCoT shifted the position from "roughly equal, depends on context" to "session auth is the safer default" — a materially different recommendation for anyone choosing between the two.

### Expected Behavior

| Aspect | Eval | Detail |
| ------ | ---- | ------ |
| Bias detection | ⭕️ | Correctly identified false equivalence: CSRF overstated, JWT misimplementation risk asymmetric, scaling concerns misframed |
| Correction quality | ⭕️ | Shifted from a hedge ("depends on context") to a concrete default recommendation |
| Overall | ⭕️ | Expected behavior |

> **Note:** This evaluation was set post-hoc after observing FCoT's output, not predicted in advance. See [APPROACH.md](../../APPROACH.md) for methodology limitations.
