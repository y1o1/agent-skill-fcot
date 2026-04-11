# トークンベンチマーク

Lightweight representative usage 条件下での FCoT のトークンコストオーバーヘッドを測定。

## 測定対象

- **Input tokens:** バリアントごとのプロンプト/コンテキストオーバーヘッド（キャッシュトークンを含む）
- **Output tokens:** バリアントごとの応答トークン数
- **Total tokens:** Input + output 合算
- **モード比較:** full vs quick モードのトークン消費
- **オーバーヘッド比率:** FCoT バリアント / Control

## 測定対象外

- 有効性（[docs/examples/](../examples/README.ja.md) を参照）
- 実会話のコンテキストスケーリング（fresh session で測定、会話途中ではない）
- レイテンシ

## 測定プロトコル

### 条件

全バリアントが対称な測定のために **separate fresh CLI sessions** を使用:

| バリアント | セッション | コマンド |
|-----------|----------|---------|
| Control | Fresh session A | `claude -p '"<statement>"' --model claude-sonnet-4-6 --disable-slash-commands --output-format json` |
| FCoT full | Fresh session B | 同じセットアップ後、`/fcot` で resume |
| FCoT quick | Fresh session C | 同じセットアップ後、`/fcot quick` で resume |

- `/tmp` から実行してプロジェクトコンテキストを回避
- 測定中は `CLAUDE.md` を無効化
- `--output-format json` の応答メタデータからトークン数を抽出
- Input tokens = `input_tokens` + `cache_creation_input_tokens` + `cache_read_input_tokens`
- FCoT バリアントは FCoT ステップ（resume）のみを報告、セットアップステップは含まない

### Statement set（3 段階の複雑性）

- Simple: "Passwords should be hashed, not stored in plaintext."
- Medium: "You should never use `any` in TypeScript."
- Complex: "AI will eventually replace most software engineers."

## 結果

### Output Tokens（主要比較）

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

### コスト (USD)

| Statement | Control | FCoT full | FCoT quick | Full overhead | Quick overhead |
|-----------|---------|-----------|------------|---------------|----------------|
| Simple (password) | $0.040 | $0.073 | $0.058 | 1.8x | 1.5x |
| Medium (typescript) | $0.050 | $0.079 | $0.060 | 1.6x | 1.2x |
| Complex (ai-replace) | $0.049 | $0.069 | $0.061 | 1.4x | 1.2x |

### 主要な発見

1. **Output overhead が意味のあるメトリクス。** Total token overhead は 1.1x にすぎない。input（〜20K tokens のシステムプロンプトとコンテキスト）が支配的であり、実際の作業が行われるのは output。

2. **Quick モードは full と比較して output を 35-56% 削減。** Quick の平均は〜1,400 output tokens、full の平均は〜2,400。削減は Control output が短い simple statements で最も顕著（7.5x → 4.2x）。

3. **コストオーバーヘッドは控えめ: 1.2-1.8x。** 1 回の呼び出しあたり $0.04-0.08 で、FCoT は $0.01-0.03 を追加。Quick モードは一貫して安い。

4. **オーバーヘッド比率は statement の複雑性が上がると低下。** Simple statements は Control 応答が短い（326 tokens）ため最も高いオーバーヘッド比率を示し、FCoT の構造化出力の固定コストがより目立つ。Control が〜1,000 tokens を書く complex statements ではオーバーヘッド比率が低下する。

## 方法論ノート

- **各条件 N=1。** 初期測定であり、統計的に検証されていない。モデルの非決定性によりトークン数は実行ごとに変動しうる。
- **モデル:** Claude Sonnet 4.6
- **日付:** 2026-04-11
- **コンテキスト:** `/tmp` からの fresh CLI sessions、プロジェクトコンテキストなし、CLAUDE.md 無効化
