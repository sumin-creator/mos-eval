#!/bin/bash
# 音声ファイルがGitに追跡されているか確認するスクリプト

echo "🔍 音声ファイルの追跡状況を確認中..."
echo ""

cd "$(dirname "$0")"

# zeval/内のwavファイルが追跡されているか確認
TRACKED=$(git ls-files | grep -E "zeval/.*\.wav" | wc -l)
TOTAL=$(find zeval -name "*.wav" 2>/dev/null | wc -l)

echo "📊 統計:"
echo "  ローカルのwavファイル数: $TOTAL"
echo "  Gitで追跡されているファイル数: $TRACKED"
echo ""

if [ "$TRACKED" -eq 0 ]; then
    echo "❌ 問題: 音声ファイルがGitで追跡されていません"
    echo ""
    echo "🔧 解決方法:"
    echo "  1. .gitignoreを一時的に無効化して追加:"
    echo "     git add -f zeval/"
    echo "  2. コミットしてpush:"
    echo "     git commit -m 'Add audio files'"
    echo "     git push"
else
    echo "✅ 音声ファイルはGitで追跡されています"
    echo ""
    echo "📝 最初の5ファイル:"
    git ls-files | grep -E "zeval/.*\.wav" | head -5
fi

