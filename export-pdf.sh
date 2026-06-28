#!/usr/bin/env bash
#
# Marp の Markdown スライドを PDF に出力するスクリプト
#
# 使い方:
#   ./export-pdf.sh                       # example/ 内をすべて PDF 化し example-pdf/ へ出力
#   ./export-pdf.sh example/02_04_custom_theme.md   # 単一ファイルを変換
#
set -euo pipefail

# スクリプトのあるディレクトリへ移動（どこから実行しても動くように）
cd "$(dirname "$0")"

# 入力（ファイル or フォルダ）。引数がなければ example/ を対象にする
INPUT="${1:-example/}"

# 出力先フォルダ
OUTDIR="example-pdf"

# カスタムテーマ（marp-themes/test.css を theme: test として参照）
THEME_DIR="marp-themes/"

mkdir -p "$OUTDIR"

if [ -d "$INPUT" ]; then
  # 入力がフォルダ: -o には出力フォルダを渡す
  OUTPUT="$OUTDIR"
else
  # 入力が単一ファイル: -o には「OUTDIR/同名.pdf」を渡す
  BASENAME="$(basename "${INPUT%.*}")"
  OUTPUT="$OUTDIR/$BASENAME.pdf"
fi

npx --yes @marp-team/marp-cli "$INPUT" \
  --theme-set "$THEME_DIR" \
  --allow-local-files \
  --pdf \
  -o "$OUTPUT"

echo "✅ PDF を $OUTPUT に出力しました"
