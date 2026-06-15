# Microsoft Scout まとめ

## 概要

Microsoft Scout は、Microsoft が 2026 年 6 月に発表した **「Autopilot」カテゴリの最初のエージェント**です。  
Windows / macOS 向けのデスクトップ AI アプリとして提供され、**ローカル PC 上のファイル・シェル・ブラウザー操作**と、**Microsoft 365 のメール・予定表・Teams・OneDrive などの業務データ**をまたいで動作します。

単なるチャット応答ではなく、**ユーザーの代わりに実際の操作を進める**ことが中心で、必要に応じて承認を取りながらタスクを継続実行できます。

## 何ができるか

- ワークスペース内のファイルの読み書き・検索
- シェル コマンド、ビルド、テスト、スクリプト実行
- ブラウザー自動操作（ページ遷移、入力、フォーム操作など）
- Microsoft 365 のメール、予定表、Teams、OneDrive、会議データの活用
- バックグラウンドでの定期実行や条件付き自動化
- サブエージェントへの委譲による並列処理
- Word / Excel / PowerPoint などのドキュメント操作

## 特徴

### 1. ローカル + クラウドの統合

Scout はローカル PC 上で動きつつ、Microsoft 365 と接続できます。  
そのため、たとえば **コードを編集してビルドし、その結果を共有し、次の打ち合わせを調整する** といった複数段階の作業を一連で扱えます。

### 2. 常時稼働寄りのエージェント

Scout は「その場で答えるチャット」よりも、**作業を継続して前に進めること**が重視されています。  
Microsoft 365 Blog では、Scout を「always-on personal agent」と位置付けており、スケジュール調整、会議準備、進行中タスクの追跡、リスク検知などを継続的に支援する想定です。

### 3. 細かな権限制御

- ファイル システム
- シェル
- ブラウザー
- Microsoft 365 連携

といった機能ごとに制御でき、**機微な操作は承認必須**にできます。  
機密パスの明示、コマンドの自動承認ルール、送信系アクションの確認など、企業利用を前提にした設計です。

### 4. Enterprise 向け設計

Microsoft は Scout を **enterprise-grade security and controls** を備えたものとして説明しています。  
Entra ID、Intune、Microsoft Purview、組織ポリシーに沿って運用される前提で、単独の個人向けツールというより **企業テナント向けの AI エージェント**です。

## 利用条件と提供状況

現時点では **一般提供ではなくプレビュー段階**です。

- **Microsoft Frontier preview program** への参加が必要
- **Microsoft 365 Copilot ライセンス**が必要
- **GitHub Copilot Business または Enterprise** が必要
- **Windows 11** または **macOS 12 以降** が必要
- **個人用 Microsoft アカウントは非対応**
- 組織管理者による **Frontier 有効化 + Intune 設定 + attestation** が必要

つまり、**アプリを入れるだけでは使えず、組織側の事前設定が必須**です。

## Copilot Chat との違い

Scout は Copilot Chat よりも **実行主体**に寄っています。

| 項目 | Copilot Chat | Microsoft Scout |
| --- | --- | --- |
| 主な役割 | 生成・要約・Q&A | 実操作を伴うタスク実行 |
| ローカル ファイル | 基本なし | あり |
| シェル実行 | なし | あり |
| ブラウザー操作 | なし | あり |
| 自律実行 | なし | あり |
| 向いている用途 | 単発の会話支援 | 複数ステップの継続作業、自動化 |

## 押さえるべきポイント

- **Microsoft Scout は「Microsoft 365 とローカル端末をまたぐ実行型 AI エージェント」**
- **Build 2026 前後で公開された新しい Autopilot の代表例**
- **企業管理下での運用が前提**
- **現時点では Frontier ベースの preview**
- **単なるチャット UI ではなく、自律実行と承認付き操作が本質**

## 参考ソース

1. Microsoft 365 Blog: Introducing Microsoft Scout: Your always-on personal agent  
   https://www.microsoft.com/en-us/microsoft-365/blog/2026/06/02/introducing-microsoft-scout-your-always-on-personal-agent/
2. Microsoft Learn: Microsoft Scout overview  
   https://learn.microsoft.com/en-us/microsoft-scout/overview
3. Microsoft Learn: Get started with Microsoft Scout  
   https://learn.microsoft.com/en-us/microsoft-scout/get-started
4. Microsoft Learn: Microsoft Scout common questions  
   https://learn.microsoft.com/en-us/microsoft-scout/faq
5. Microsoft Learn: Admin access overview for Microsoft Scout  
   https://learn.microsoft.com/en-us/microsoft-scout/admin-access-overview
