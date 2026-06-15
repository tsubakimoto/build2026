# Build 2026 における Microsoft Foundry Hosted Agents のアップデートまとめ

## 概要

Build 2026 の Hosted Agents まわりは、**「エージェントをクラウド上で安全にホストする基盤」から「本番運用まで含めたエージェント実行基盤」へ進んだ**のがポイントです。

Build のニュースでは、Foundry Agent Service の Hosted Agents は次のように説明されています。

- **preview**
- **session ごとの instant-on sandbox**
- **isolated execution**
- **persistent memory**
- **elastic scale**

ニュース原文では、Hosted agents は **“the primitive for agents the way containers were for cloud-native apps”** と位置づけられており、Foundry 側が「AI エージェント版の実行基盤」を強く打ち出した形です。

## Build 2026 で何が新しい/強調されたか

### 1. Hosted Agents が Foundry Agent Service の中核ランタイムとして前面化

Build のニュースと Learn の両方を合わせると、Hosted Agents は次の構成で整理できます。

- **自前コードをそのまま持ち込める**
- **Microsoft 管理インフラ上で実行**
- **各セッションが VM-isolated sandbox**
- **`$HOME` と `/files` の永続化**
- **セッションごとのスケール**
- **専用の Microsoft Entra ID (agent identity)**

単なる prompt agent と違い、Hosted Agents は **コンテナ化したアプリケーションとして動く**のが本質です。

### 2. 本番運用ストーリーがかなり明確になった

Build の BRK241 と LIVE170 は、Hosted Agents を **ローカル試作 → 安全なデプロイ → 運用監視** までつなぐ話でした。

特に強調されているのは次です。

- **identity**
- **secure networking**
- **evaluations**
- **lifecycle management**
- **production-grade AI systems**

つまり Hosted Agents は、Build 2026 時点で **「動くデモ」ではなく「運用可能な agent runtime」** として説明されています。

### 3. 長時間・複数エージェント・状態保持の設計が現実解に近づいた

BRK243 では Hosted Agents のアーキテクチャ上で、次のような要素が語られています。

- **long-running agents**
- **triggers**
- **state management**
- **file access**
- **multi-agent workflows**
- **continuous evals**

Learn 側でも、Hosted Agents は **session** と **conversation** を分けて扱い、15 分アイドルで compute を落としつつ、状態を戻せる設計になっています。これにより、**scale-to-zero と stateful resume を両立**しているのが大きな特徴です。

### 4. プロトコルとフレームワークの幅が広がった

Learn の Hosted Agents 概念ページでは、1 つの hosted agent が複数プロトコルを持てる構成が整理されています。

- **Responses**
- **Invocations**
- **Invocations (WebSocket / preview)**
- **Activity**
- **A2A (preview)**

Build セッションではさらに、

- **Microsoft Agent Framework**
- **LangGraph / LangChain**
- **GitHub Copilot SDK**
- **Claude Agent SDK**
- **custom harness**

が前提として扱われており、Hosted Agents は **Foundry 純正フレームワーク専用機能ではなく、外部 OSS を受け止めるランタイム** として強化されています。

### 5. Observability / Eval / 保護が Hosted Agents の標準ストーリーに入った

LAB540 は Hosted Agents の運用を次の流れで扱っています。

- **observe**
- **optimize**
- **protect**
- **context-specific evaluation suites**
- **continuous evaluation**
- **trace-linked analysis**

Build 2026 の Hosted Agents は、単なるホスティングではなく、**評価・トレース・継続改善込みの運用面**がセットで語られているのが特徴です。

### 6. TypeScript / OSS 統合の現実味が増した

LTG446 と DEM333 から読み取れるのは、Hosted Agents が Python/C# だけで閉じず、**TypeScript LangChain や OSS ベースの OpenClaw 的エージェントも Foundry 側で運用できる**方向へ進んでいることです。

これは「Foundry を使うには全部作り直す必要がある」というより、**既存スタックを持ち込んで運用基盤だけ Foundry に寄せる**発想に近いです。

## Hosted Agents の実務的な意味

Build 2026 の文脈で Hosted Agents が重要なのは、次の 5 点です。

1. **コンテナ、スケーリング、監視、セッション復元を自前実装しなくてよい**
2. **agent identity により下流 Azure サービスへ安全に接続しやすい**
3. **Responses / Invocations の使い分けが明確**
4. **状態保持付きの長時間エージェント設計がしやすい**
5. **評価・運用・デプロイ更新まで一貫化できる**

特に「AI エージェントを本番に出すと、アプリ本体より周辺運用のほうが難しい」問題に対して、Hosted Agents はかなり直接的な答えになっています。

## Build 2026 で押さえるべきセッション

### 最重要

| セッション | 内容 | メモ |
|---|---|---|
| **LIVE170** — Hosted Agents Live: From Code to Production AI at Scale | Hosted Agents の Build 時点の位置づけを最も端的に示す | Broadcast Stage / オンデマンドあり |
| **BRK241** — From prototype to production: build and run agents at scale | Foundry Agent Service + Microsoft Agent Framework で本番導線を説明 | identity / networking / evaluations / lifecycle |
| **BRK243** — Claw and agent harness in Microsoft Foundry | hosted agents architecture と multi-agent / long-running 系 | 上級者向け |
| **LAB540** — Observe, optimize and protect your hosted agents in Microsoft Foundry | Hosted Agents の評価・監視・保護を実践 | 運用寄り |

### 補助的に見るとよい

| セッション | 内容 | メモ |
|---|---|---|
| **LTG446** — TypeScript LangChain agents on Microsoft Foundry Agents Service | TypeScript / LangChain の現実的な載せ方 | OSS 既存資産がある人向け |
| **DEM333** — How Foundry integrates with open-source frameworks and tools | OSS + MCP + OpenTelemetry + hosted agents の橋渡し | 実装イメージを掴みやすい |

### セッション URL

- LIVE170: https://build.microsoft.com/en-US/sessions/LIVE170
- BRK241: https://build.microsoft.com/en-US/sessions/BRK241
- BRK243: https://build.microsoft.com/en-US/sessions/BRK243
- LAB540: https://build.microsoft.com/en-US/sessions/LAB540
- LTG446: https://build.microsoft.com/en-US/sessions/LTG446
- DEM333: https://build.microsoft.com/en-US/sessions/DEM333

## MS Learn で見つかるサンプルコード

以下は **Microsoft Learn / 公式ドキュメント** から拾える Hosted Agents 関連コードです。

### 1. Python: Responses protocol の最小 Hosted Agent

出典: **Foundry Hosted Agents**
https://learn.microsoft.com/agent-framework/hosting/foundry-hosted-agent

```python
import os

from agent_framework import Agent
from agent_framework.foundry import FoundryChatClient
from agent_framework_foundry_hosting import ResponsesHostServer
from azure.identity import DefaultAzureCredential

client = FoundryChatClient(
    project_endpoint=os.environ["FOUNDRY_PROJECT_ENDPOINT"],
    model=os.environ["AZURE_AI_MODEL_DEPLOYMENT_NAME"],
    credential=DefaultAzureCredential(),
)

agent = Agent(
    client=client,
    instructions="You are a helpful AI assistant.",
    default_options={"store": False},
)

server = ResponsesHostServer(agent)
server.run()
```

**見るポイント**

- `ResponsesHostServer` で Hosted Agent 化できる
- `store=False` にして会話履歴の二重保持を避ける
- Foundry 側の Responses protocol に素直に乗せられる

### 2. C#: Responses protocol の最小 Hosted Agent

出典: **Foundry Hosted Agents**
https://learn.microsoft.com/agent-framework/hosting/foundry-hosted-agent

```csharp
using Azure.AI.AgentServer.Core;
using Azure.AI.Projects;
using Azure.Identity;
using Microsoft.Agents.AI;
using Microsoft.Agents.AI.Foundry.Hosting;

var projectEndpoint = new Uri(Environment.GetEnvironmentVariable("FOUNDRY_PROJECT_ENDPOINT")
    ?? throw new InvalidOperationException("FOUNDRY_PROJECT_ENDPOINT is not set."));
var deployment = Environment.GetEnvironmentVariable("AZURE_AI_MODEL_DEPLOYMENT_NAME") ?? "gpt-4o";

AIAgent agent = new AIProjectClient(projectEndpoint, new DefaultAzureCredential())
    .AsAIAgent(
        model: deployment,
        instructions: "You are a helpful AI assistant.",
        name: "my-agent");

var builder = AgentHost.CreateBuilder(args);
builder.Services.AddFoundryResponses(agent);
builder.RegisterProtocol("responses", endpoints => endpoints.MapFoundryResponses());

var app = builder.Build();
app.Run();
```

**見るポイント**

- C# では `AgentHost.CreateBuilder` + `AddFoundryResponses`
- OpenAI 互換 `/responses` エンドポイントを簡単に公開できる

### 3. Python: Invocations protocol のカスタム処理

出典: **Foundry Hosted Agents**
https://learn.microsoft.com/agent-framework/hosting/foundry-hosted-agent

このページには、`InvocationAgentServerHost` を使って **custom JSON payload / custom SSE / session 管理** を自分で持つ例もあります。

**向いているケース**

- webhook 受信
- 非 conversational な処理
- 独自 UI / 独自プロトコル連携
- GitHub Copilot など外部プロトコルとの bridge

### 4. C#: Visualizer / OpenTelemetry サンプル

出典: **Create hosted agent workflows in the Microsoft Foundry Toolkit for Visual Studio Code extension**
https://learn.microsoft.com/azure/foundry/agents/how-to/vs-code-agents-workflow-pro-code

```csharp
using System.Diagnostics;
using OpenTelemetry;
using OpenTelemetry.Logs;
using OpenTelemetry.Metrics;
using OpenTelemetry.Resources;
using OpenTelemetry.Trace;

var otlpEndpoint =
    Environment.GetEnvironmentVariable("OTLP_ENDPOINT") ?? "http://localhost:4319";

var resourceBuilder = OpenTelemetry
    .Resources.ResourceBuilder.CreateDefault()
    .AddService("WorkflowSample");

var s_tracerProvider = OpenTelemetry
    .Sdk.CreateTracerProviderBuilder()
    .SetResourceBuilder(resourceBuilder)
    .AddSource("Microsoft.Agents.AI.*")
    .SetSampler(new AlwaysOnSampler())
    .AddOtlpExporter(options =>
    {
        options.Endpoint = new Uri(otlpEndpoint);
        options.Protocol = OpenTelemetry.Exporter.OtlpExportProtocol.Grpc;
    })
    .Build();
```

**見るポイント**

- Hosted workflow の可視化
- OpenTelemetry を使った実行グラフの観測
- LAB540 の observability 文脈とつながる

## 学習用チュートリアル

### 1. Hosted Agents の概念をつかむ

**What are hosted agents?**  
https://learn.microsoft.com/azure/foundry/agents/concepts/hosted-agents

最初に読むべきページです。以下が整理されています。

- Hosted Agents を使うべき場面
- VM-isolated sandbox
- Responses / Invocations / WebSocket
- session / conversation
- agent identity
- observability
- toolbox
- scaling / limits / pricing

### 2. 最短で 1 つ動かす

**Quickstart: Deploy your first hosted agent**  
https://learn.microsoft.com/azure/foundry/agents/quickstarts/quickstart-hosted-agent

これが最短学習ルートです。

- `azd ai agent init`
- ローカル実行
- Foundry Agent Service への deploy
- playground / CLI から invoke

**Hosted Agents をまだ触っていない人は、まずこれを完走するのが最優先**です。

### 3. VS Code ベースで作る

**Create hosted agent workflows in the Microsoft Foundry Toolkit for Visual Studio Code extension**  
https://learn.microsoft.com/azure/foundry/agents/how-to/vs-code-agents-workflow-pro-code

こちらは GUI ベースで学びたい場合に向いています。

- Hosted Agent のテンプレート作成
- Python / C# 両対応
- ローカル実行
- Visualizer
- Foundry Toolkit から deploy

### 4. Agent Framework で Hosted Agent に載せる

**Foundry Hosted Agents**  
https://learn.microsoft.com/agent-framework/hosting/foundry-hosted-agent

コードを読むならここが最重要です。

- Python / C# の最小コード
- Responses protocol
- Invocations protocol
- ローカル実行
- `azd` での deploy

### 5. 運用・バージョン管理を学ぶ

**Manage hosted agents**  
https://learn.microsoft.com/azure/foundry/agents/how-to/manage-hosted-agent

デプロイ後に必要になる内容です。

- agent/version の確認
- 新しい version の作成
- traffic routing
- logstream
- agent identity の principal ID 取得
- RBAC role assignment

## おすすめ学習順

### 最短ルート

1. **What are hosted agents?**
2. **Quickstart: Deploy your first hosted agent**
3. **Foundry Hosted Agents**
4. **Manage hosted agents**

### C# 中心で学ぶ場合

1. **What are hosted agents?**
2. **Create hosted agent workflows in the Microsoft Foundry Toolkit for Visual Studio Code extension**
3. **Foundry Hosted Agents**
4. **Manage hosted agents**

### 運用まで含めて学ぶ場合

1. **Quickstart**
2. **Manage hosted agents**
3. **LAB540 / BRK241 / BRK243 の録画または資料**

## 一言でいうと

Build 2026 の Hosted Agents は、**「自前のエージェントコードを Foundry 上で安全に運用するための本番ランタイム」**として位置づけがかなり明確になりました。

特に重要なのは、

- **session ごとの isolated sandbox**
- **persistent state / files**
- **agent identity**
- **protocol の柔軟性**
- **observability / eval / lifecycle**

の 5 つです。

## 参考ソース

- Build 2026 News: https://aka.ms/build2026-news
- What are hosted agents?: https://learn.microsoft.com/azure/foundry/agents/concepts/hosted-agents
- Quickstart: Deploy your first hosted agent: https://learn.microsoft.com/azure/foundry/agents/quickstarts/quickstart-hosted-agent
- Create hosted agent workflows in the Microsoft Foundry Toolkit for Visual Studio Code extension: https://learn.microsoft.com/azure/foundry/agents/how-to/vs-code-agents-workflow-pro-code
- Foundry Hosted Agents: https://learn.microsoft.com/agent-framework/hosting/foundry-hosted-agent
- Manage hosted agents: https://learn.microsoft.com/azure/foundry/agents/how-to/manage-hosted-agent
