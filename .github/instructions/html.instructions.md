---
applyTo: '**/*.html'
---

以下の 3 ファイルの HTML スタイルを基準として、今後の HTML はこの指示に統一すること。

- `csharp\build2026-csharp-updates.html`
- `microsoft-foundry\microsoft-foundry-build-2026-features.html`
- `copilot-token\build2026-github-copilot-token-optimization-sessions.html`

## 基本方針

- 日本語の情報整理ページとして、読みやすさを優先した **カード型レイアウト** を採用する。
- **ライトモードを既定** とし、**ダークモードへ切り替え可能** にする。
- 単一カラム中心で、PC では余白を広く、モバイルでは余白と角丸をやや詰める。
- 装飾は増やしすぎず、`hero` と `content` の 2 枚構成を基本とする。

## HTML 構造

ページ構造は原則として次を使うこと。

```html
<body>
    <button class="theme-toggle" type="button" aria-label="テーマ切り替え" onclick="toggleTheme()">🌙 ダークモード</button>
    <div class="page">
        <header class="hero">
            <h1>ページタイトル</h1>
            <p>Markdown をもとに整形した HTML 版です。ライトモードが既定で、右上のボタンからダークモードに切り替えられます。</p>
        </header>
        <main class="content">
            <!-- 本文 -->
        </main>
    </div>
</body>
```

## head の基準

- `<!DOCTYPE html>` を使う。
- `<html lang="ja">` を使う。
- `<meta charset="UTF-8">` と `<meta name="viewport" content="width=device-width, initial-scale=1.0">` を必ず入れる。
- `<title>` はページ内容をそのまま表す簡潔な日本語タイトルにする。
- スタイルはページ内の `<style>` に含め、単独で見ても表示が成立するようにする。

## カラートークン

CSS カスタムプロパティ名は次で統一すること。

```css
:root {
    color-scheme: light;
    --bg: #f5f7fb;
    --surface: #ffffff;
    --surface-muted: #f0f4fa;
    --text: #1b1f24;
    --muted: #5a6472;
    --border: #d7deea;
    --accent: #0f6cbd;
    --accent-strong: #084b91;
    --code-bg: #eef3f9;
    --shadow: 0 20px 40px rgba(15, 108, 189, 0.08);
}

html.dark-mode {
    color-scheme: dark;
    --bg: #0f1722;
    --surface: #182230;
    --surface-muted: #111a26;
    --text: #e8eef7;
    --muted: #aab7c8;
    --border: #2a3a4f;
    --accent: #7cc2ff;
    --accent-strong: #a7d7ff;
    --code-bg: #0f1a28;
    --shadow: 0 24px 48px rgba(0, 0, 0, 0.32);
}
```

- 新しい HTML を作るときも、基本はこの配色を使う。
- 特別な理由がない限り、変数名は増やさず既存トークンで表現する。

## レイアウトと余白

- `body` は `margin: 0;`、`font-family: "Segoe UI", "Hiragino Kaku Gothic ProN", Meiryo, sans-serif;`、`line-height: 1.75;` を基準とする。
- 背景は `linear-gradient(180deg, var(--surface-muted) 0%, var(--bg) 180px)` を使う。
- `.page` は `max-width: 980px; margin: 0 auto; padding: 72px 20px 40px;` を基本とする。
- `.hero` と `.content` は以下で統一する。
  - `background: var(--surface);`
  - `border: 1px solid var(--border);`
  - `border-radius: 24px;`
  - `padding: 28px;`
  - `box-shadow: var(--shadow);`
- `.hero` は `margin-bottom: 24px;` を付ける。

## タイポグラフィ

- `.hero h1` は `color: var(--accent);` を使い、`font-size: clamp(2rem, 4vw, 2.8rem);` を基準とする。
- `.hero p` は導入文として短く保ち、`color: var(--muted);` を使う。
- `.content > h1:first-child { display: none; }` を入れ、本文側に重複した先頭 `h1` があっても見出しを二重表示しない。
- `.content h2` はセクション区切りとして、下線付き・アクセント色にする。
- `.content h3` は本文見出しとして、本文色ベースで少し大きめにする。
- `h2`, `h3`, `h4` には `scroll-margin-top: 88px;` を入れる。

## 本文要素

- 本文領域の対象は `.content` に限定してスタイルする。
- 段落、リスト、表は `margin: 1rem 0;` を基準とする。
- `ul`, `ol` は `padding-left: 1.4rem;` を使う。
- `li + li` に `margin-top: 0.45rem;` を入れて詰まりすぎを防ぐ。
- リンクは `var(--accent)`、ホバー時は `var(--accent-strong)` と下線を使う。
- `strong` は `var(--accent)` を使い、本文の強調色を統一する。

## コード・引用・表

- `code` は `var(--code-bg)` の淡い背景、角丸、`Consolas` 系フォントを使う。
- `pre` は `border: 1px solid var(--border); border-radius: 16px; padding: 16px; overflow-x: auto;` を使う。
- `pre code` は背景を透明に戻し、二重装飾を避ける。
- 表は `.content table` に対して以下を適用する。
  - `width: 100%;`
  - `display: block;`
  - `overflow-x: auto;`
  - `border-collapse: collapse;`
  - `border: 1px solid var(--border);`
  - `border-radius: 16px;`
- `th`, `td` は `padding: 12px 14px; border: 1px solid var(--border); text-align: left; vertical-align: top;` を使う。
- `th` は `background: var(--surface-muted); color: var(--accent);` にする。
- `blockquote` は左にアクセント色の罫線を付け、背景は `var(--surface-muted)` にする。

## テーマ切り替え

- テーマ切り替えは `html.dark-mode` の付け外しで実装する。
- ボタン文言は必ず **「ライトモード」「ダークモード」** を使う。
- 保存キーは `localStorage` の **`preferred-theme`** を使う。
- 既定値はライトモードにする。
- スクリプトは原則として次のロジックに揃えること。

```html
<script>
    const root = document.documentElement;
    const button = document.querySelector('.theme-toggle');

    function setTheme(theme) {
        const dark = theme === 'dark';
        root.classList.toggle('dark-mode', dark);
        button.textContent = dark ? '☀️ ライトモード' : '🌙 ダークモード';
        localStorage.setItem('preferred-theme', theme);
    }

    function toggleTheme() {
        setTheme(root.classList.contains('dark-mode') ? 'light' : 'dark');
    }

    const savedTheme = localStorage.getItem('preferred-theme');
    setTheme(savedTheme === 'dark' ? 'dark' : 'light');
</script>
```

## レスポンシブ対応

- ブレークポイントはまず `@media (max-width: 720px)` を基準にする。
- モバイルでは以下を行う。
  - `.page` の左右余白を縮める。
  - `.hero` と `.content` の `padding` を 20px にする。
  - 角丸を 18px にする。
  - `.theme-toggle` の位置と余白を少し詰める。
  - 表のセルは `white-space: normal; min-width: 140px;` にして折り返し可能にする。

## 文章と運用ルール

- 導入文は 1 段落で、ページの用途とテーマ切り替えの説明までに留める。
- 本文は Markdown 由来の構造を活かし、無理に独自コンポーネント化しない。
- 新しい HTML を作るときは、まずこの標準スタイルを使い、明確な差分が必要なときだけ最小限に拡張する。
- 既存ページの改修でも、可能な限りこの命名・配色・構造へ寄せる。
