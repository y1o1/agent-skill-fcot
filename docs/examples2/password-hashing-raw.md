> "Passwords should be hashed, not stored in plaintext."

Absolutely — this is one of the most foundational principles in application security. Here's why it matters and what good practice looks like:

**Why hashing is essential:**
When a database is breached (and breaches happen to even well-resourced organizations), plaintext passwords hand attackers immediate access to every user's account — and since people reuse passwords, the damage spreads far beyond your system.

**What hashing does:**
A cryptographic hash function transforms a password into a fixed-length string that cannot be reversed. When a user logs in, you hash what they type and compare it to the stored hash — the original password never needs to be stored or re-derived.

**Use the right algorithm:**
Not all hashes are equal. `MD5` and `SHA-1` are fast — and that's a liability, since attackers can run billions of guesses per second. Use algorithms specifically designed for passwords:
- **bcrypt** — widely supported, time-tested
- **Argon2** — winner of the Password Hashing Competition, current best practice
- **scrypt** — memory-hard, strong alternative

These are intentionally slow and include a built-in **salt** (random per-user data) to defeat rainbow table attacks.

**Never roll your own:** Use your language/framework's vetted library — `bcrypt` in Node.js, `Werkzeug`/`passlib` in Python, `spring-security-crypto` in Java, etc.

The statement is correct and the advice is well-established. Hashing passwords is non-negotiable in modern software.

> /fcot

## FCoT: Passwords must be hashed (not stored in plaintext) using a slow, salted algorithm

### Counter-Arguments

| # | Counter-Argument | Dismissal Condition | Verification | Result |
|---|-----------------|---------------------|--------------|--------|
| 1 | Hashing is not always sufficient — if the hash algorithm is weak (e.g., MD5, SHA-1 without salt), hashed passwords can still be cracked via rainbow tables or brute force, so "hash passwords" without qualification is dangerously incomplete advice | Dismissed if the response explicitly recommends strong, purpose-built algorithms and mentions salting, not hashing in general | My Turn 1 response explicitly named bcrypt, Argon2, and scrypt; explained they are "intentionally slow"; and stated they "include a built-in salt." The advice was not generic — it was algorithm-specific with rationale. | ✓ |
| 2 | For some systems (e.g., legacy authentication protocols like CHAP, NTLM, or PAP), the server must be able to reproduce or verify the original password in a way that standard one-way hashing prevents, making plaintext or reversible storage a technical requirement | Dismissed if the response is scoped to modern, general-purpose web/application authentication rather than claiming universality across all authentication schemes | The response is implicitly scoped to standard application login flows ("When a user logs in, you hash what they type and compare"). It does not claim to cover all protocols. However, the opening statement ("Passwords should be hashed, not stored in plaintext") is stated without qualification — a reader could apply it universally. This is a genuine gap: no acknowledgment that legacy protocol constraints exist. | ✗ |
| 3 | Hashing at the application layer is irrelevant if the password is exposed in transit (no TLS), in logs, or in memory dumps — the statement addresses storage but ignores the broader threat model, giving a false sense of completeness | Dismissed if the response is accurately scoped to storage security specifically, without implying hashing alone is a complete security solution | The response is explicitly about storage ("a database is breached"). It does not claim to be a complete security checklist. Scoping to storage is reasonable and the claim holds within that scope. | ✓ |
| 4 | Hardware Security Modules (HSMs) or encrypted storage solutions could be considered an alternative to hashing for certain regulated environments — the blanket claim that hashing is the only correct approach may exclude valid enterprise patterns | Dismissed if the counter-argument conflates encryption (reversible) with hashing (irreversible), or if HSM-based approaches still rely on hashing internally for password verification | Encryption-at-rest is not equivalent to password hashing for authentication: if the encryption key is compromised, all passwords are exposed. HSMs for password storage still perform hashing internally. The counter-argument conflates two different security layers. | ✓ |
| 5 | Recommending "use your language's vetted library" without addressing the risk of deprecated or poorly maintained libraries (e.g., an old bcrypt binding with known vulnerabilities) could give false assurance | Dismissed if the advice to use vetted libraries is a reasonable baseline recommendation and the failure mode (unmaintained library) is a general software maintenance concern, not a flaw in the hashing-over-plaintext judgment itself | The counter-argument attacks the completeness of library guidance, not the core judgment. A recommendation to use vetted libraries is sound baseline advice; keeping dependencies updated is a separate, universal concern. The core judgment (hash passwords) is not undermined. | ✓ |

### Conclusion

**Revision needed (narrow scope)**

Counter-argument #2 stands. The statement "passwords should be hashed, not stored in plaintext" is correct and well-supported for the vast majority of use cases — standard web and application authentication. However, it is stated without qualification, and there exist specific legacy authentication protocols (CHAP, NTLM, some RADIUS configurations) where one-way hashing is architecturally incompatible with protocol requirements. A fully rigorous version of the Turn 1 response should either:

- Scope the claim explicitly: *"In standard application authentication, passwords must be hashed..."*, or
- Acknowledge the edge case: *"...with narrow exceptions for legacy challenge-response protocols that require access to the original credential."*

The practical advice — use bcrypt/Argon2/scrypt, avoid MD5/SHA-1, don't roll your own — is sound and stands intact. The revision needed is in precision of scope, not in the substance of the recommendation.
