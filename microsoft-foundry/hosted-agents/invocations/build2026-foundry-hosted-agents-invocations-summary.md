# Build 2026 の Foundry Hosted Agents アップデートから見る `invocations` まとめ

## 要点

Build 2026 の Hosted Agents における `invocations` は、**Foundry が chat 専用ホスティングではなく、任意の入出力契約を受け止める agent runtime へ広がった**ことを示すアップデートです。

`responses` が OpenAI 互換の会話 API なのに対し、`invocations` は **bytes in / bytes out** の生の受け渡しです。つまり、Hosted Agents 上のコンテナが自分で JSON、SSE、Webhook payload、独自 UI 向けイベントを定義でき、Foundry はそれをセッション付きで安全に動かす実行基盤になります。

## Build 2026 文脈での位置づけ

Hosted Agents 全体の Build 2026 での進化は、次の流れで理解すると分かりやすいです。

1. **セッション単位の isolated sandbox**
2. **永続状態 (`$HOME` / `/files`)**
3. **agent identity と安全な接続**
4. **複数プロトコル対応**
5. **評価・監視・運用まで含む本番導線**

この中で `invocations` は、特に **「複数プロトコル対応」** を実務に落とし込むための中核です。Build 2026 では Hosted Agents が以下のプロトコルを持てる形で整理されました。

| プロトコル | 役割 | 向いている用途 |
|---|---|---|
| `responses` | OpenAI 互換の会話 API | 通常のチャット、Copilot 的な対話 |
| `invocations` | HTTP ベースのカスタム入出力 | webhook、分類、抽出、独自フロントエンド、プロトコル bridge |
| `invocations_ws` | 双方向 WebSocket | 音声、リアルタイム streaming、シグナリング |

要するに、Build 2026 のアップデートでは **Hosted Agents が「LLM チャットを置く場所」から「任意プロトコルの agent backend」を置く場所へ拡張された**、その代表が `invocations` です。

## `invocations` の本質

`invocations` の重要点は 3 つです。

### 1. 入出力スキーマをプラットフォームが決めない

`responses` では `inputText` が自然言語メッセージとして扱われますが、`invocations` では **HTTP リクエストボディがそのままコンテナに渡されます**。

- JSON を受けてもよい
- バイナリを受けてもよい
- SSE を返してもよい
- 独自の request / response 契約でもよい

このため `invocations` は、LLM との会話というより **「Hosted Agent を自前 API として公開する」** 感覚に近いです。

### 2. 会話履歴ではなくセッション状態で継続する

`responses` は `conversationId` による platform-managed history が中心ですが、`invocations` はそうではありません。

- 状態継続は **`sessionId` ベース**
- 会話や処理コンテキストは **agent 側が管理**
- Hosted Agents の永続ストレージと組み合わせて resume できる

つまり `invocations` は、**会話 API というより stateful worker/session runtime** として使うのが自然です。

### 3. 外部システムとの接続点になれる

Build セッション群で強調されていた「OSS フレームワーク対応」「custom harness」「GitHub Copilot SDK などとの橋渡し」は、`invocations` と相性が良いです。

典型例:

- GitHub / Jira / Stripe などの webhook 受信
- 独自 UI から structured payload を送る
- MCP や独自プロトコルの bridge を置く
- 非 conversational な分類・抽出・変換 API を実装する

## Hosted Agents のアップデートとして見た価値

`invocations` が重要なのは、Build 2026 の Hosted Agents の価値を次のように具体化するからです。

| Build 2026 の強調点 | `invocations` で何ができるか |
|---|---|
| セッションごとの sandbox | 呼び出しごとに分離された安全な処理実行 |
| 永続ファイル / 状態 | ワークフロー途中の状態や生成物を保持 |
| elastic scale | webhook やバックエンド処理をスケールさせやすい |
| identity / networking | 下流 Azure サービスへ安全に接続できる |
| observability / eval | 実処理を trace し、運用評価につなげられる |

これにより `invocations` は、単なるカスタム API ではなく **Foundry の本番運用機能を持った custom agent endpoint** として使えます。

## `responses` とどう使い分けるか

最も実務的な整理は次の通りです。

| 使い分け | 選ぶべきもの |
|---|---|
| 人との会話が中心 | `responses` |
| UI や外部システムから構造化データを渡したい | `invocations` |
| 双方向で低遅延に流したい | `invocations_ws` |
| session 単位で状態を持つ独自処理を動かしたい | `invocations` |

Build 2026 の Hosted Agents は、**まず `responses` で始め、要件が会話 API をはみ出したら `invocations` に寄せる**という判断がしやすくなったと言えます。

## Build セッションで特に関連が深いもの

| セッション | `invocations` 観点での読みどころ |
|---|---|
| [LIVE170](https://build.microsoft.com/en-US/sessions/LIVE170) | Hosted Agents を本番ランタイムとしてどう使うかの全体像 |
| [BRK241](https://build.microsoft.com/en-US/sessions/BRK241) | prototype から production へ持っていく際の identity / networking / lifecycle |
| [BRK243](https://build.microsoft.com/en-US/sessions/BRK243) | long-running、state、multi-agent など `invocations` と相性が良い設計論 |
| [LAB540](https://build.microsoft.com/en-US/sessions/LAB540) | 実運用で trace / eval / protect をどう回すか |
| [DEM333](https://build.microsoft.com/en-US/sessions/DEM333) | OSS や外部ツールとの接続先として Hosted Agents をどう使うか |

## 実務での理解

一言でいうと、Build 2026 の `invocations` は **「Foundry Hosted Agents を会話 API ではなく、セッション付きのカスタム agent backend として使えるようにしたもの」**です。

その結果、Hosted Agents は次の領域までカバーできるようになりました。

- conversational agent
- webhook-driven agent
- structured processing endpoint
- tool / protocol bridge
- stateful long-running backend

## 補助ドキュメント

- Hosted Agents 概念: https://learn.microsoft.com/azure/foundry/agents/concepts/hosted-agents
- Foundry Hosted Agents: https://learn.microsoft.com/agent-framework/hosting/foundry-hosted-agent
- Quickstart: https://learn.microsoft.com/azure/foundry/agents/quickstarts/quickstart-hosted-agent
- Manage hosted agents: https://learn.microsoft.com/azure/foundry/agents/how-to/manage-hosted-agent

## 結論

Build 2026 の Hosted Agents アップデートを `invocations` から見ると、重要なのは **Foundry が chat endpoint の提供だけでなく、任意スキーマ・任意ワークフローの agent 実行基盤へ拡張された**ことです。

`responses` が「会話」、`invocations` が「カスタム処理」、`invocations_ws` が「リアルタイム双方向」と整理できるため、Hosted Agents の設計判断がかなり明確になりました。
