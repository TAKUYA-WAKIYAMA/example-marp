# Marp スライドを PDF で出力する方法

Marp の Markdown スライドを PDF に書き出す方法をまとめます。
このリポジトリでは大きく 2 通りの方法があります。

- **A. VS Code 拡張機能（Marp for VS Code）で出力する** … 手軽。GUI 操作で完結。
- **B. Marp CLI で出力する** … コマンドで一括・自動化向き。

どちらの方法でも、対象の Markdown 先頭に Marp 用のフロントマターが必要です。

```markdown
---
marp: true
---
```

> 例: [`example/02_01_base1.md`](../example/02_01_base1.md) や、カスタムテーマを使う [`example/02_04_custom_theme.md`](../example/02_04_custom_theme.md) を参照。

---

## A. VS Code 拡張機能で出力する

### 1. 拡張機能をインストール

VS Code の拡張機能マーケットプレイスで **「Marp for VS Code」**（発行元: Marp team）をインストールします。

### 2. スライドをプレビュー

1. `marp: true` を含む Markdown ファイル（例: `example/02_04_custom_theme.md`）を開く。
2. 右上の **プレビュー（虫眼鏡付きアイコン）** をクリックし、Marp プレビューを表示する。

### 3. PDF にエクスポート

1. コマンドパレットを開く（macOS: `Cmd+Shift+P` / Windows: `Ctrl+Shift+P`）。
2. **「Marp: Export Slide Deck...」** を実行する。
3. 保存ダイアログでファイル形式に **PDF** を選び、保存先を指定する。

> このリポジトリの [`example-pdf/02_04_custom_theme.pdf`](../example-pdf/02_04_custom_theme.pdf) は、この方法で出力した例です。

### 4. （任意）ローカルファイルや数式を使う場合の設定

ローカル画像（`![bg](../images/...)` など）や一部機能を PDF に含めるには、VS Code 設定で Marp の以下のオプションを有効化します。

- 設定 ID: `markdown.marp.enableHtml`（HTML を使う場合）
- ローカルリソースを読み込むため、Markdown と画像は同一ワークスペース内に置く。

このリポジトリでは画像を [`images/`](../images/) に、テーマを [`marp-themes/`](../marp-themes/) に置いています。

---

## B. Marp CLI で出力する

コマンドで PDF を生成します。CI や複数ファイルの一括出力に向いています。

### 1. 前提

- [Node.js](https://nodejs.org/) がインストールされていること。
- PDF 出力では内部で Chromium が必要です（CLI が自動で利用、または `npx` 経由で取得）。

### 2. 単発で実行（インストール不要）

`npx` を使えばグローバルインストールせずに実行できます。

```bash
# example/02_04_custom_theme.md を PDF に出力
npx @marp-team/marp-cli example/02_04_custom_theme.md --pdf -o example-pdf/02_04_custom_theme.pdf
```

`--pdf` を付けるか、出力ファイル名を `.pdf` にすると PDF として書き出されます。

```bash
# 出力先の拡張子で形式を判定させる書き方
npx @marp-team/marp-cli example/02_04_custom_theme.md -o example-pdf/02_04_custom_theme.pdf
```

### 3. カスタムテーマを指定する

このリポジトリは [`marp-themes/test.css`](../marp-themes/test.css) を `theme: test` として参照しています。CLI でテーマを読み込むには `--theme-set` を指定します。

```bash
npx @marp-team/marp-cli example/02_04_custom_theme.md \
  --theme-set marp-themes/ \
  --pdf -o example-pdf/02_04_custom_theme.pdf
```

### 4. ローカル画像を含める

ローカルファイル（`../images/...` など）を読み込むには `--allow-local-files` を付けます。

```bash
npx @marp-team/marp-cli example/02_04_custom_theme.md \
  --theme-set marp-themes/ \
  --allow-local-files \
  --pdf -o example-pdf/02_04_custom_theme.pdf
```

> `--allow-local-files` はローカルファイルへのアクセスを許可するため、信頼できる Markdown にのみ使用してください。

### 5. フォルダ内をまとめて変換

`example/` 内のすべての Markdown を変換する例です。

```bash
npx @marp-team/marp-cli example/ \
  --theme-set marp-themes/ \
  --allow-local-files \
  --pdf -o example-pdf/
```

### 6. スクリプトでまとめて実行

このリポジトリには上記の CLI 実行をまとめた [`export-pdf.sh`](../export-pdf.sh) を用意しています。

```bash
# example/ 内をすべて PDF 化し example-pdf/ へ出力
./export-pdf.sh

# 単一ファイルを変換
./export-pdf.sh example/02_04_custom_theme.md
```

中身は `--theme-set marp-themes/`・`--allow-local-files`・`--pdf` を付けた Marp CLI 呼び出しです。

### 7. （任意）グローバルインストール

頻繁に使う場合はインストールしておくと `marp` コマンドで実行できます。

```bash
npm install -g @marp-team/marp-cli

marp example/02_04_custom_theme.md --theme-set marp-themes/ --allow-local-files --pdf
```

---

## よく使うオプションまとめ（CLI）

| オプション | 説明 |
| --- | --- |
| `--pdf` | PDF 形式で出力する |
| `-o <path>` | 出力先ファイル / フォルダを指定する |
| `--theme-set <dir/file>` | カスタムテーマ（CSS）を読み込む |
| `--allow-local-files` | ローカル画像などローカルファイルの読み込みを許可する |
| `--pdf-notes` | スピーカーノートを PDF の注釈として埋め込む |
| `-w` / `--watch` | ファイル変更を監視して自動再出力する |

---

## トラブルシューティング

- **画像が表示されない** … ローカル画像は CLI なら `--allow-local-files`、VS Code 拡張なら Marp 設定でローカルリソースを許可する。パスが Markdown からの相対パスになっているか確認する。
- **テーマが反映されない** … フロントマターの `theme:` 名と、`--theme-set` で読み込んだ CSS 内の `/* @theme test */` 宣言が一致しているか確認する。
- **PDF 生成に失敗する（CLI）** … Chromium が見つからない場合がある。Chrome / Chromium をインストールするか、`CHROME_PATH` 環境変数で実行ファイルを指定する。

---

## 参考リンク

- Marp 公式: <https://marp.app/>
- Marp CLI: <https://github.com/marp-team/marp-cli>
- Marp for VS Code: <https://marketplace.visualstudio.com/items?itemName=marp-team.marp-vscode>
- このリポジトリの作例の参考記事: <https://qiita.com/tomo_makes/items/aafae4021986553ae1d8>
