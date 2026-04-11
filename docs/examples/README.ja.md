# FCoT — 比較サンプル

FCoTがAIの応答をどう変えるかを並べて比較。各サンプルでは、同じ判断をFCoTなし/ありで検証した結果を示す。

## 技術系

- [JWT vs セッション認証](jwt-vs-session.ja.md) — 「セッションベース認証はJWTより安全」
- [TypeScript `any`](typescript-any.ja.md) — 「TypeScriptでanyは絶対使うべきではない」
- [モノリス vs マイクロサービス](monolith-vs-microservices.ja.md) — 「マイクロサービスよりモノリスから始めるべき」
- [グローバルステート](global-state.ja.md) — 「グローバルステートは悪であり、常に避けるべき」
- [ユニットテスト優先](unit-before-integration.ja.md) — 「ユニットテストは常にインテグレーションテストの前に書くべき」

## 一般

- [リモートワーク](remote-work.ja.md) — 「リモートワークはオフィスワークより生産性が高い」
- [文法 vs 会話](grammar-vs-conversation.ja.md) — 「英語学習はまず文法より会話から始めるべき」
- [AIがエンジニアを置き換える](ai-replace-engineers.ja.md) — 「AIはいずれほとんどのソフトウェアエンジニアを置き換える」
- [大学教育](university-education.ja.md) — 「大学教育はソフトウェアエンジニアにとって不要になりつつある」

## 健全な判断

- [パスワードハッシュ](password-hashing.ja.md) — 「パスワードは平文ではなくハッシュ化して保存すべき」
- [SQLインジェクション](sql-injection.ja.md) — 「SQLインジェクションはパラメタライズドクエリで防げる」
- [コードレビュー](code-reviews.ja.md) — 「コードレビューは有益であり、すべてのチームが行うべき」

FCoTは常に結論を変えるわけではない。判断が健全な場合は、それを確認しつつ、注意すべきエッジケースを明らかにする。

## 評価サマリー

| 例 | FCoT 結果 | 有効性 | 根拠 |
| -- | --------- | ------ | ---- |
| [文法 vs 会話](grammar-vs-conversation.ja.md) | 変更 (4/4) | ⭕️ | 追従的なControlを全面的に覆した。化石化、学習者タイプ、Krashenの誤用を発見 |
| [JWT vs セッション認証](jwt-vs-session.ja.md) | 修正 (4/4) | ⭕️ | 偽の対称フレーミングを修正。構造的失効ギャップと非対称攻撃面を特定 |
| [モノリス vs マイクロサービス](monolith-vs-microservices.ja.md) | 確認 (0/6) | ⭕️ | 6反論を検証して健全性を確認。追従ではなく根拠付きの確認 |
| [パスワードハッシュ](password-hashing.ja.md) | 狭い修正 (2/4) | ⭕️ | 核心原則を確認しつつ、PBKDF2の欠落と不正確なSHA否定で精度を向上 |
| [リモートワーク](remote-work.ja.md) | 軽微な修正 (1/6) | 🔺 | async-first組織の区別を発見。ただしControlがすでに十分で追加価値は限定的 |
| [TypeScript any](typescript-any.ja.md) | 修正 (4/4) | ⭕️ | migration、metaprogramming、test mocks、サードパーティ型の4つの正当な例外を発見 |
| [AIがエンジニアを置き換える](ai-replace-engineers.ja.md) | 大幅修正 (4/4) | ⭕️ | 原理的上限の不在、需要弾力性の不確実性、経済的インセンティブ — 楽観的フレーミングを大幅修正 |
| [SQLインジェクション](sql-injection.ja.md) | 修正 (3/3) | ⭕️ | Controlの「Correct.」に対し、動的識別子、不完全な適用、2次インジェクションを発見 |
| [グローバルステート](global-state.ja.md) | 修正 (2/5) | ⭕️ | すでに批判的なControlに対し、初期化順序バグと並列テストコストでさらに精度向上 |
| [ユニットテスト優先](unit-before-integration.ja.md) | 確認 (1/5条件付き) | ⭕️ | TDD・test pyramidを含む5反論を検証して健全性を確認 |
| [コードレビュー](code-reviews.ja.md) | 修正 (2/5) | ⭕️ | 追従的な「Agreed」に対し、コンテキスト感度と実行品質依存性を発見 |
| [大学教育](university-education.ja.md) | ほぼ健全 (1/5) | 🔺 | オンラインリソースのギャップ縮小を発見。ただしControlがすでに十分で追加価値は限定的 |

**有効性: 10 / 12（83.3%）** — FCoTが判断を有意義に改善または検証したか？ ⭕️ = 1、🔺 = 0.5、❌ = 0。

**期待一致度: 6.5 / 12（54.2%）** — FCoTの結論方向が事前定義または事後の予測と一致したか？（各exampleファイルに個別の期待評価あり。）

### 方法論と限界

- **N=12、定性的、単一モデル**（Claude Sonnet 4.6）。統計的検定なし、再現性の検証なし。
- **サンプリングバイアス。** 判断文はランダムではなく、デモンストレーション価値で選択。
- **事前定義 vs 事後評価。** 12件中6件が事前定義された期待結果を使用（AIがエンジニアを置き換える、SQLインジェクション、グローバルステート、ユニットテスト優先、コードレビュー、大学教育）。残り6件はFCoTの出力を観察した後に「期待」結果を設定。サンプルは主にプロセスの挙動をデモンストレーションするものであり、効果の測定ではない。
- **コンテキスト分離プロトコル。** 各サンプルは `/tmp` から別々のCLIプロセスで実行し、プロジェクトコンテキストの汚染を回避。Controlは `--disable-slash-commands`（FCoTスキルなし）で生成、FCoTは同一セッションを resume して `/fcot` で生成。`~/.claude/CLAUDE.md` とワークスペースの `CLAUDE.md` は実行中無効化。詳細は[実行プロトコル](#実行プロトコル)を参照。
- **コンテキスト汚染（過去のラウンド）。** 過去のサンプリング（ここには含まない）で2つの汚染形態を発見: (1) `CLAUDE.md` の反追従指示が通常より反論的なControl応答を生成、(2) ControlとFCoTを同一コンテキストで実行すると一貫性バイアスが発生（FCoTが自らの先行出力との整合性を維持）。現在のプロトコルは両方に対処。詳細は [APPROACH.ja.md](../../APPROACH.ja.md) を参照。
- **モデル間比較なし。** すべてのサンプルが同一モデル。FCoTの効果が異なるモデルファミリーでも成立するかは未検証。

### 実行プロトコル

各サンプルは以下の2ステップCLIプロセスで生成:

```bash
# 前提条件: すべてのCLAUDE.mdファイルを無効化
mv ~/.claude/CLAUDE.md ~/.claude/CLAUDE.md.disabled
mv /path/to/workspace/.claude/CLAUDE.md /path/to/workspace/.claude/CLAUDE.md.disabled

# Step 1: Control（/tmp から実行してプロジェクトコンテキストを回避、スキル無効）
cd /tmp && claude -p '"<statement>"' \
  --model claude-sonnet-4-6 \
  --disable-slash-commands \
  --output-format json > <slug>.control.json

SESSION_ID=$(python3 -c "import json; print(json.load(open('<slug>.control.json'))['session_id'])")

# Step 2: FCoT（同じセッションを resume、スキル有効）
cd /tmp && claude -p "/fcot" \
  --model claude-sonnet-4-6 \
  --resume "$SESSION_ID" \
  --output-format text > <slug>.fcot.md

# 全実行後にCLAUDE.mdファイルを復元
mv ~/.claude/CLAUDE.md.disabled ~/.claude/CLAUDE.md
mv /path/to/workspace/.claude/CLAUDE.md.disabled /path/to/workspace/.claude/CLAUDE.md
```

このプロトコルが保証すること:

- **プロジェクトコンテキスト汚染なし** — `/tmp` 作業ディレクトリによりプロジェクトファイルの読み込みを防止
- **CLAUDE.mdバイアスなし** — 反追従指示やその他の行動指示を無効化
- **ステートメント間の相互汚染なし** — 各ステートメントが独自のCLIプロセスで実行
- **ステートメント内のコンテキスト継続** — FCoTは同一セッションを resume するため、自身のControl応答を参照可能
- **スキル分離** — ControlステップはFCoTスキルにアクセス不可、FCoTステップはアクセス可能
