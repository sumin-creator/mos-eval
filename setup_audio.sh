#!/bin/bash
# 音声ファイルをmos-evalディレクトリにコピーするスクリプト

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="/home/sumino/zeval"
TARGET_DIR="$SCRIPT_DIR/zeval"

echo "📁 音声ファイルをコピー中..."
echo "  ソース: $SOURCE_DIR"
echo "  ターゲット: $TARGET_DIR"

if [ ! -d "$SOURCE_DIR" ]; then
    echo "❌ エラー: $SOURCE_DIR が見つかりません"
    exit 1
fi

# ターゲットディレクトリを作成
mkdir -p "$TARGET_DIR"

# 音声ファイルをコピー
cp -r "$SOURCE_DIR"/* "$TARGET_DIR/"

echo "✅ コピー完了！"
echo ""
echo "次のステップ:"
echo "  1. cd $SCRIPT_DIR"
echo "  2. git add ."
echo "  3. git commit -m 'Add audio files'"
echo "  4. git push"

