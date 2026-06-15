# Build 2026 の C# アップデートまとめ

Microsoft Build 2026 で C# 開発者がまず押さえるべき変化は、**C# 15 プレビュー + .NET 11 プレビュー + Visual Studio 2026 の AI 強化**です。安定版で今すぐ使うなら **C# 14 / .NET 10**、次世代の方向性を見るなら **C# 15 / .NET 11** が中心です。

## 1. C# 言語そのもの

### いまの安定版: C# 14

C# 14 は .NET 10 で正式サポートされており、次の機能が入っています。

- Extension members
- null-conditional assignment
- `nameof(List<>)` のような unbound generic types 対応
- `Span<T>` / `ReadOnlySpan<T>` の暗黙変換強化
- simple lambda parameter modifiers
- `field` backed properties
- partial events / partial constructors
- user-defined compound assignment operators

特に実務で効きやすいのは、**`field` backed properties** と **null-conditional assignment**、そして **extension members** です。既存コードを大きく崩さずに、C# の記述量と補助型の量を減らしやすくなります。

### Build 2026 で見るべき新顔: C# 15 プレビュー

C# 15 は **.NET 11 preview** と **Visual Studio 2026 Insiders** で試せます。現時点の目玉は次の 3 つです。

- **Collection expression arguments**: `with(...)` でコレクション式から capacity や comparer を渡せる
- **Union types**: 代数的データ型に近いモデルを素直に表現しやすい
- **Closed hierarchies**: 継承階層を閉じて `switch` の網羅性を強化できる

Build の C# 目線では、**「C# が AI 向け API を増やした」よりも、「型モデリングとパターンマッチの表現力をかなり押し上げた」** のが大きいです。特に API 契約、ワークフロー状態、ドメインイベントの表現がやりやすくなります。

## 2. .NET 11 で C# 開発体験がどう変わるか

### Runtime Async

.NET 11 では **Runtime Async** が大きな変化です。コンパイラ生成の async state machine 依存を減らし、ランタイム管理へ寄せる方向で進んでいます。

- ライブスタックトレースがかなり見やすくなる
- デバッグ時に async のノイズが減る
- NativeAOT / ReadyToRun でも扱いやすい
- async-heavy なコードでオーバーヘッド低減が狙える

async を多用する C# アプリ、特に ASP.NET Core やクラウド API では影響が大きい変更です。

### JIT / AOT / 実行性能

.NET 11 runtime では次も注目です。

- bounds check 除去の強化
- checked context の冗長除去
- `SequenceEqual` などの定数畳み込み強化
- ReadyToRun の改善
- WebAssembly / NativeAOT / Arm 系の最適化強化

一方で、**最小ハードウェア要件が引き上げ** られているため、古い x64 / Arm64 環境をまだ抱えている場合は Build 後に確認が必要です。

## 3. ASP.NET Core / Blazor で効く更新

Build の C# Web 開発者向けとしては、.NET 11 の ASP.NET Core も当たり年です。

### Blazor

- `DisplayName` コンポーネント追加
- Blazor Server / WebAssembly の startup options 形式がそろう
- **新しい Blazor WebAssembly 開発サーバー** (`Microsoft.AspNetCore.Components.Gateway`)
- **`IHostedService` が Blazor WebAssembly で利用可能**
- Static SSR でクライアント側バリデーション対応
- async form validation の基盤追加

### Web API / Minimal APIs / OpenAPI

- **Blazor と Minimal APIs のエラーローカライズを強化**
- **OpenAPI 3.2 対応**
- バイナリレスポンスの OpenAPI 生成改善
- HTTP QUERY の OpenAPI 表現に対応
- OpenTelemetry の追加計装ライブラリなしでも一部 semantic convention 属性を直接出力

要するに、Build 2026 の ASP.NET Core は **「AI を載せる土台」だけでなく、Blazor と API の実務機能もかなり前進** しています。

## 4. Visual Studio 2026 と Copilot が C# 開発に与える変化

Visual Studio 2026 の更新は、C# 開発者にはかなり直接的です。

### デバッグ / テスト / 性能解析

- **Smart Watch Suggestions**: Watch window で文脈に応じた式候補
- **Profile Tests with Copilot**: Test Explorer から .NET テストをそのままプロファイル
- **Perf Tips powered by live profiling**: デバッグしながら実行時間やホットスポットを見て、その場で Copilot に最適化相談

### Copilot ワークフロー

- **Long-distance next edit suggestions**
- **MCP trust validation**
- **PR を Copilot Chat に直接追加**
- **Agent Skills の一覧管理**
- **Multi-file summary diff**
- **Planning mode**

Build 2026 の C# 体験は、単なるコード補完より **「診断・修正・レビューまで Copilot が IDE に深く入ってきた」** ことが新しいポイントです。

## 5. C# 開発者向けの注目セッション

### 直接おすすめ

| セッション | 形式 | なぜ見るべきか |
|---|---|---|
| **OD802** — Building for the agentic web with .NET 11 | Pre-recorded | ASP.NET Core / Blazor / Aspire / agentic web をまとめて追える |
| **OD806** — .NET 11 in depth: Runtime, libraries, and SDK for the AI era | Pre-recorded | .NET 11 全体の技術的な芯を把握しやすい |
| **BRK207** — GitHub Copilot in Visual Studio: Agents That Debug, Profile, and Test | Breakout | C# / .NET 開発でのデバッグ・性能解析・テスト支援が直結 |
| **OD805** — AI Building Blocks for .NET: Add intelligence to your C# apps | Pre-recorded | C# アプリに AI をどう組み込むかの実践寄り |
| **OD803** — Taking your AI to the edge with .NET MAUI | Pre-recorded | C# / MAUI でローカル AI・エッジ AI を追うなら最短 |
| **OD804** — Simplifying .NET Installs with dotnetup | Pre-recorded | SDK / Runtime 管理の運用面を改善したいなら有用 |

### 現地参加なら

| セッション | 時間 | メモ |
|---|---|---|
| **BRK207** | Jun 3, 4:00 PM PDT | C# / .NET 向けに一番実務直結 |
| **LTG406** — Get More Than Autocomplete: GitHub Copilot Workflows in Visual Studio | Jun 2, 4:10 PM PDT | Visual Studio の日常フロー寄り |
| **DEMSP394** — Scale enterprise .NET apps with AI-assisted cross-platform workflows | Jun 2, 2:40 PM PDT | エンタープライズ .NET と AI ワークフロー |
| **TT656** — From Locked-In to Liquid: Modernizing .NET Before the November 2026 EOL | Jun 2, 3:15 PM PDT | .NET 8/9 EOL を見据えた移行の話 |

## 6. C# 開発者としての実務インパクト

### すぐ使うなら

1. **C# 14 / .NET 10 / Visual Studio 2026** を前提に、`field` backed properties、null-conditional assignment、extension members を押さえる
2. Visual Studio の **Watch / profiling / Copilot diff / planning** をチーム開発フローに入れる
3. Blazor / Minimal APIs を使っているなら .NET 11 の差分を先に読む

### 次を見据えるなら

1. **C# 15 の union types と closed hierarchies** をドメインモデルで試す
2. **Runtime Async** を async-heavy な API やサービスで検証する
3. **OD802 / OD806 / BRK207** を見て、Web・ランタイム・IDE の 3 面で Build 2026 を把握する

## 参照元

- C# 14: https://learn.microsoft.com/dotnet/csharp/whats-new/csharp-14
- C# 15: https://learn.microsoft.com/dotnet/csharp/whats-new/csharp-15
- .NET 11 runtime: https://learn.microsoft.com/dotnet/core/whats-new/dotnet-11/runtime
- ASP.NET Core in .NET 11: https://learn.microsoft.com/aspnet/core/release-notes/aspnetcore-11
- Visual Studio 2026 release notes: https://learn.microsoft.com/visualstudio/releases/2026/release-notes
- Build 2026 news: https://aka.ms/build2026-news
- Build 2026 session catalog: https://aka.ms/build2026-session-info
