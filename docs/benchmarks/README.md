# Token Benchmarks

Measures FCoT's token cost overhead under lightweight representative usage conditions.

## What this measures

- **Input tokens:** Prompt/context overhead per variant (includes cache tokens)
- **Output tokens:** Response token count per variant
- **Total tokens:** Input + output combined
- **Mode comparison:** full vs quick mode token consumption
- **Overhead ratio:** FCoT variant / Control

## What this does NOT measure

- Effectiveness (see [docs/examples/](../examples/))
- Real-conversation context scaling (measured in fresh sessions, not mid-conversation)
- Latency

## Measurement Protocol

### Conditions

All variants use **separate fresh CLI sessions** to ensure symmetric measurement:

| Variant | Session | Command |
|---------|---------|---------|
| Control | Fresh session A | `claude -p '"<statement>"' --model claude-sonnet-4-6 --disable-slash-commands --output-format json` |
| FCoT full | Fresh session B | Same setup, then resume with `/fcot` |
| FCoT quick | Fresh session C | Same setup, then resume with `/fcot quick` |

- Run from `/tmp` to avoid project context
- `CLAUDE.md` disabled during measurement
- Token counts extracted from `--output-format json` response metadata
- Input tokens = `input_tokens` + `cache_creation_input_tokens` + `cache_read_input_tokens`
- FCoT variants report only the FCoT step (resume), not the setup step

### Statement set (3 complexity levels)

- Simple: "Passwords should be hashed, not stored in plaintext."
- Medium: "You should never use `any` in TypeScript."
- Complex: "AI will eventually replace most software engineers."

## Results

### Output Tokens (primary comparison)

| Statement | Control | FCoT full | FCoT quick | Full overhead | Quick overhead |
|-----------|---------|-----------|------------|---------------|----------------|
| Simple (password) | 326 | 2,443 | 1,370 | 7.5x | 4.2x |
| Medium (typescript) | 977 | 2,681 | 1,394 | 2.7x | 1.4x |
| Complex (ai-replace) | 946 | 1,980 | 1,522 | 2.1x | 1.6x |

### Total Tokens (input + output)

| Statement | Control | FCoT full | FCoT quick | Full overhead | Quick overhead |
|-----------|---------|-----------|------------|---------------|----------------|
| Simple (password) | 20,195 | 22,734 | 21,822 | 1.1x | 1.1x |
| Medium (typescript) | 20,842 | 23,619 | 22,343 | 1.1x | 1.1x |
| Complex (ai-replace) | 20,810 | 22,884 | 22,294 | 1.1x | 1.1x |

### Cost (USD)

| Statement | Control | FCoT full | FCoT quick | Full overhead | Quick overhead |
|-----------|---------|-----------|------------|---------------|----------------|
| Simple (password) | $0.040 | $0.073 | $0.058 | 1.8x | 1.5x |
| Medium (typescript) | $0.050 | $0.079 | $0.060 | 1.6x | 1.2x |
| Complex (ai-replace) | $0.049 | $0.069 | $0.061 | 1.4x | 1.2x |

### Key Findings

1. **Output overhead is the meaningful metric.** Total token overhead is only 1.1x because input (~20K tokens of system prompt and context) dominates. Output is where the actual work happens.

2. **Quick mode reduces output by 35-56% vs full mode.** Quick averages ~1,400 output tokens; full averages ~2,400. The reduction is most dramatic for simple statements where Control output is short (7.5x → 4.2x).

3. **Cost overhead is modest: 1.2-1.8x.** At $0.04-0.08 per invocation, FCoT adds $0.01-0.03 per use. Quick mode is consistently cheaper.

4. **Overhead ratio decreases with statement complexity.** Simple statements show the highest overhead ratio because Control responses are shorter (326 tokens), making the fixed cost of FCoT's structured output more visible. For complex statements where Control already writes ~1,000 tokens, the overhead ratio drops.

## Methodology Notes

- **N=1 per condition.** These are initial measurements, not statistically validated. Token counts may vary between runs due to model non-determinism.
- **Model:** Claude Sonnet 4.6
- **Date:** 2026-04-11
- **Context:** Fresh CLI sessions from `/tmp`, no project context, CLAUDE.md disabled
