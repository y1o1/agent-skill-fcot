# Password Hashing

> **Subject:** "Passwords should be hashed, not stored in plaintext."

## Without FCoT

```
> Passwords should be hashed, not stored in plaintext.

Absolutely — this is one of the most foundational principles in application security.

Why hashing is essential: When a database is breached (and breaches happen to even
well-resourced organizations), plaintext passwords hand attackers immediate access to
every user's account — and since people reuse passwords, the damage spreads far beyond
your system.

What hashing does: A cryptographic hash function transforms a password into a
fixed-length string that cannot be reversed. When a user logs in, you hash what they
type and compare it to the stored hash — the original password never needs to be stored
or re-derived.

Use the right algorithm: Not all hashes are equal. MD5 and SHA-1 are fast — and that's
a liability. Use algorithms designed for passwords:
- bcrypt — widely supported, time-tested
- Argon2 — winner of the Password Hashing Competition, current best practice
- scrypt — memory-hard, strong alternative

These are intentionally slow and include a built-in salt to defeat rainbow table
attacks.

Never roll your own: Use your language/framework's vetted library — bcrypt in Node.js,
Werkzeug/passlib in Python, spring-security-crypto in Java, etc.

The statement is correct and the advice is well-established. Hashing passwords is
non-negotiable in modern software.
```

## With FCoT

```
> /fcot

## FCoT: Passwords must be hashed (not stored in plaintext) using a slow, salted algorithm

### Counter-Arguments

| # | Counter-Argument | Dismissal Condition | Verification | Result |
|---|-----------------|---------------------|--------------|--------|
| 1 | Weak hashing (MD5, unsalted SHA-1) is still crackable. | Dismissed if response recommends strong algorithms + salting. | Response named bcrypt/Argon2/scrypt, explained slow + salted. | ✓ |
| 2 | Legacy protocols (CHAP, NTLM) need the original password. | Dismissed if scoped to modern web auth. | Response is implicitly scoped but opening is unqualified. Gap. | ✗ |
| 3 | Hashing is irrelevant if password is exposed in transit/logs. | Dismissed if scoped to storage security. | Response is explicitly about storage ("a database is breached"). | ✓ |
| 4 | HSMs/encrypted storage could be an alternative. | Dismissed if this conflates encryption with hashing. | Encryption ≠ hashing. HSMs still hash internally. Conflation. | ✓ |
| 5 | "Use vetted library" doesn't address deprecated libs. | Dismissed if this is a general maintenance concern. | General concern, not a flaw in the hashing judgment itself. | ✓ |

### Conclusion

**Revision needed (narrow scope).**

Counter-argument #2 stands. Specific legacy protocols (CHAP, NTLM) require access
to the original credential. A more precise version: "In standard application
authentication, passwords must be hashed..."
```

### Analysis

#### Counter-Arguments

| # | Counter-Argument | Dismissal Condition | Verification | Result |
|---|-----------------|---------------------|--------------|--------|
| 1 | Hashing with a weak algorithm (MD5, SHA-1 without salt) can still be cracked — "hash passwords" without qualification is dangerously incomplete. | Dismissed if the response explicitly recommends strong algorithms and mentions salting. | The response named bcrypt, Argon2, and scrypt; explained they are "intentionally slow" and include built-in salt. The advice was algorithm-specific. | ✓ |
| 2 | Some legacy authentication protocols (CHAP, NTLM, PAP) require the server to reproduce or verify the original password in a way that one-way hashing prevents. | Dismissed if the response is scoped to modern, general-purpose web authentication rather than claiming universality. | The response is implicitly scoped to standard login flows. However, the opening statement is unqualified — a reader could apply it universally. No acknowledgment that legacy protocol constraints exist. | ✗ |
| 3 | Hashing at the application layer is irrelevant if the password is exposed in transit (no TLS), in logs, or in memory dumps. | Dismissed if the response is accurately scoped to storage security. | The response is explicitly about storage ("a database is breached"). It does not claim to be a complete security checklist. | ✓ |
| 4 | HSMs or encrypted storage could be considered an alternative to hashing in regulated environments. | Dismissed if the counter-argument conflates encryption (reversible) with hashing (irreversible). | Encryption-at-rest is not equivalent to password hashing for authentication. If the encryption key is compromised, all passwords are exposed. HSMs for password storage still perform hashing internally. | ✓ |
| 5 | "Use your language's vetted library" doesn't address deprecated or poorly maintained libraries. | Dismissed if this is a general software maintenance concern, not a flaw in the hashing-over-plaintext judgment. | The counter-argument attacks completeness of library guidance, not the core judgment. Keeping dependencies updated is a separate, universal concern. | ✓ |

#### Summary

This example shows that **FCoT doesn't always overturn the conclusion.** The AI's initial response was correct — password hashing is a well-established security principle, and the practical advice (bcrypt/Argon2/scrypt) was sound.

FCoT still added value by surfacing one edge case: legacy authentication protocols (CHAP, NTLM) that architecturally require access to the original credential. The judgment stands for standard web authentication — but could be stated more precisely.

This demonstrates an important property: FCoT is not a contrarianism tool. When a judgment is sound, FCoT confirms it. When it finds issues, they're genuine — not manufactured disagreement.
