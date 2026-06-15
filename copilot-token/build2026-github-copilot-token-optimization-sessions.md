# Build 2026 で GitHub Copilot のトークン削減に関係するセッション

Build 2026 の公開セッション catalog を確認した限り、**「トークン削減」や「token reduction」そのものを主題にした GitHub Copilot セッションは見当たりませんでした。**

その代わり、**Copilot の使用量最適化、無駄なコンテキスト消費の削減、プロンプトやスキル設計による効率化**に直結するセッションはあります。トークン消費を抑える観点では、以下が有力です。

## 最有力

### LTG402 — Why GitHub Copilot misses context (and how to fix it)

- **日時**: Jun 3, 3:20 PM PDT
- **形式**: Lightning Talk
- **場所**: Gateway Pavilion, Level 2, Theater 3
- **登壇者**: Harald Kirschner, Courtney Webster
- **セッション URL**: https://build.microsoft.com/en-US/sessions/LTG402

**関連性**

- 説明に **shared rules**, **reusable prompts**, **custom agents**, **skills** が明記されている
- Copilot が「文脈をうまく知らない」状態をどう補うかが主題
- 無駄な再説明や広すぎるプロンプトを減らし、**必要なコンテキストだけを与える設計**に直結する

**トークン削減の観点**

- 一番近い本命です
- プロンプトファイル、ルール、スキルの整理で **毎回の入力量を減らす** 方向の話と読めます

## 次点

### LAB502 — Make GitHub Copilot Work Your Way: Custom Tools, Context and Workflows

- **日時**: Jun 2, 3:00 PM PDT
- **形式**: Lab
- **場所**: Firehouse
- **登壇者**: Josh Johanning, Tiago Pascoal
- **セッション URL**: https://build.microsoft.com/en-US/sessions/LAB502

**関連性**

- タイトルに **Context** があり、説明でも **custom agents**, **Agent Skills**, **MCP** を扱う
- チーム固有のワークフローへ合わせて Copilot を整える実践寄りセッション

**トークン削減の観点**

- スキルやツールに知識を寄せることで、チャット本文に毎回長い背景を書く必要を減らせる
- **「会話で都度説明する」から「構造化したコンテキストを再利用する」** へ寄せるヒントが得られそうです

## 関連度高

### LTG401 — 10 ways to maximize GitHub Copilot

- **日時**: Jun 2, 3:30 PM PDT
- **形式**: Lightning Talk
- **場所**: Gateway Pavilion, Level 2, Theater 1
- **登壇者**: Aaron Powell
- **セッション URL**: https://build.microsoft.com/en-US/sessions/LTG401

**関連性**

- 「maximize GitHub Copilot」が主題で、隠れた活用法の紹介
- token/usage の明示はないが、効率的な使い方のヒントは期待できる

**トークン削減の観点**

- 直接度は LTG402 や LAB502 より低い
- ただし **少ないやり取りで成果を出す使い方** を拾える可能性があります

## 関連度中

### DEM305 — GitHub Copilot Anywhere: From Remote Control CLIs to Cloud Sandboxes

- **日時**: Jun 3, 10:30 AM PDT
- **形式**: Demo
- **場所**: Gateway Pavilion, Level 2, Theater C
- **登壇者**: Ellie Bennett, Denizhan Yigitbas
- **セッション URL**: https://build.microsoft.com/en-US/sessions/DEM305

**関連性**

- CLI から cloud sandbox まで、Copilot を環境横断で使う話
- **コンテキストを失わず継続する** という説明がある

**トークン削減の観点**

- 文脈の引き継ぎが良くなるほど、同じ説明を何度も繰り返さずに済む
- ただし主題は token optimization ではなく、マルチ環境での継続利用です

## 周辺トピック

### LAB532 — From data to context: Agent-ready knowledge with Foundry IQ

- **日時**: Jun 2, 3:00 PM PDT
- **形式**: Lab
- **場所**: Building C, Level 2, Room 205
- **登壇者**: Ayca Bas, Pamela Fox
- **セッション URL**: https://build.microsoft.com/en-US/sessions/LAB532

**関連性**

- GitHub Copilot CLI に対して、Foundry IQ と MCP で **必要な知識をライブコンテキストとして供給** する内容
- 説明文に **no custom RAG plumbing required** とあり、コンテキスト設計の観点で興味深い

**トークン削減の観点**

- 直接 Copilot の token 使用量削減を語るわけではない
- ただし **必要な知識を検索可能な形で外出し** する考え方は、長文プロンプト削減にかなり相性が良い

## 結論

「GitHub Copilot のトークン削減」に一番近いセッションは次の順です。

1. **LTG402** — Why GitHub Copilot misses context (and how to fix it)
2. **LAB502** — Make GitHub Copilot Work Your Way: Custom Tools, Context and Workflows
3. **LTG401** — 10 ways to maximize GitHub Copilot
4. **DEM305** — GitHub Copilot Anywhere: From Remote Control CLIs to Cloud Sandboxes
5. **LAB532** — From data to context: Agent-ready knowledge with Foundry IQ

## 補足

Build のセッション catalog では、**usage-based billing** や **token quota** を正面から扱う GitHub Copilot セッションは確認できませんでした。もし「トークン消費を減らす実践ノウハウ」を探しているなら、Build 2026 のセッションとしては **LTG402** と **LAB502** を優先して追うのがよさそうです。

## 参照元

- Build 2026 session catalog: https://aka.ms/build2026-session-info
