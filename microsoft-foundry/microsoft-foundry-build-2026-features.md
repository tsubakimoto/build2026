# Microsoft Foundry の Build 2026 新機能まとめ

## 概要

Microsoft Build 2026 における Microsoft Foundry の発表は、**「モデルを使う場所」から「本番運用できる AI エージェント基盤」への進化**が中心です。  
特に、**ホスティング、ツール接続、メモリ、ナレッジ基盤、評価・ガバナンス、モデル運用**が大きく強化されました。

## 主な新機能

### 1. Hosted Agents の強化

- Foundry Agent Service の **Hosted Agents** が本番利用向けに大きく前進
- セッションごとに **サンドボックス化された実行環境**
- **状態保持** と **ファイルシステムアクセス** をサポート
- Microsoft Agent Framework、GitHub Copilot SDK、LangGraph など **複数フレームワーク対応**
- **Routines** により、タイマーやスケジュールでの自律実行が可能

意味合いとしては、単発の推論ではなく、**長時間動くエージェントを Foundry 上で安全に動かせる**ようになった点が大きいです。

### 2. Toolboxes in Foundry

- **Toolboxes** が Public Preview
- ツール、スキル、MCP クライアント、エンタープライズ データ接続を **1 つの管理エンドポイント** に集約
- スキルを **プロジェクト単位でバージョン管理**
- **Tool search** により、タスクに必要なツールを絞り込んで提示

これにより、エージェントごとに個別接続を作り込むのではなく、**ツール利用の統制と再利用**がしやすくなりました。

### 3. Memory の拡張

Foundry Agent Service の **Memory** が Public Preview で拡張され、以下の 3 種類をサポートします。

- **Procedural memory**: どう作業したかを学習して再利用
- **User memory**: ユーザーの好みや前提を記憶
- **Session memory**: 会話スレッド内の文脈を保持

特に Procedural memory は、Build 2026 で強調された新要素で、**過去の成功パターンを次回以降に活かせる**点が重要です。

### 4. Foundry IQ の拡張

Foundry IQ は、単なる検索補助ではなく、**Foundry の知識・グラウンディング基盤**として強化されました。

- **Serverless retrieval**
- **Knowledge bases**
- **新しい knowledge sources**
- **Web IQ** によるライブ Web グラウンディング
- セキュリティや agentic retrieval の改善

Work IQ、Fabric IQ、Azure SQL、File Search、MCP ソースなどをまとめて扱えるため、**RAG のための個別実装を減らせる**のがポイントです。

### 5. Teams / Microsoft 365 Copilot への発行

- Foundry で作成したエージェントを **Microsoft Teams** や **Microsoft 365 Copilot** に公開可能
- ID、権限、ポリシーを Microsoft 側の管理基盤に沿って適用

つまり、エージェントを作るだけでなく、**実際の業務チャネルに届ける導線**まで Foundry 側で持てるようになっています。

### 6. Developer Tooling の強化

- **Foundry Toolkit for VS Code** が GA
- エージェントのテンプレート作成
- ローカル実行とトレース可視化
- Toolbox 接続
- Foundry Agent Service へのデプロイ

開発体験として、**VS Code を中心にローカル開発からデプロイまでつなげやすくなった**のが改善点です。

### 7. モデルと計算基盤の拡充

- **MAI モデル群**の拡張
- **Fireworks AI on Foundry** の GA
- **Managed Compute**
- **Fine-tuning** と **Frontier Tuning**

これにより、モデル選択肢だけでなく、**推論・学習・カスタマイズの運用面**も強化されています。

### 8. 評価・ガバナンス・可観測性

Build 2026 では、エージェント運用の信頼性向上も大きなテーマでした。

- **ASSERT**: ポリシー駆動の評価
- **Agent Control Specification (ACS)**: 入力、モデル、状態、ツール実行、出力の各チェックポイント制御
- **Guided Guardrail Setup**
- **Rubric evaluator**
- **Tracing and evaluations**
- **Agent Optimizer**
- **Agent ROI**

要するに、作るだけでなく **評価・監視・安全制御・改善のループ**を Foundry 上で回しやすくなっています。

## 特に重要なポイント

Build 2026 の Foundry で重要なのは、次の 4 点です。

1. **Hosted Agents により、本番向けエージェント実行基盤が整ってきた**
2. **Toolboxes と Foundry IQ により、ツール接続と知識接続が標準化された**
3. **Memory により、継続性のあるエージェント設計がしやすくなった**
4. **評価・ガバナンス機能により、企業運用の現実解に近づいた**

## 一言でいうと

Microsoft Foundry の Build 2026 新機能は、**「AI モデル活用基盤」から「本番エージェントの開発・運用プラットフォーム」への進化**です。

## 参考ソース

1. Microsoft Foundry Blog: What’s new in Microsoft Foundry | Build Edition  
   https://devblogs.microsoft.com/foundry/whats-new-in-microsoft-foundry-build-2026/
2. Microsoft Foundry Blog: Toolboxes / Memory / Agent Service 関連記事
3. Microsoft Learn / Build セッション情報（上記記事内リンク）
