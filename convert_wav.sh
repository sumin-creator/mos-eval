#!/bin/bash
# WAVファイルをブラウザ対応形式（PCM 16-bit, 44.1kHz, mono）に一括変換

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ZEVAL_DIR="$SCRIPT_DIR/zeval"

echo "🎵 WAVファイルをブラウザ対応形式に変換中..."
echo ""

# ffmpegの確認
if ! command -v ffmpeg &> /dev/null; then
    echo "❌ エラー: ffmpeg がインストールされていません"
    echo "   インストール: sudo apt-get install ffmpeg"
    exit 1
fi

# zevalディレクトリの確認
if [ ! -d "$ZEVAL_DIR" ]; then
    echo "❌ エラー: $ZEVAL_DIR が見つかりません"
    exit 1
fi

# 変換前の統計
TOTAL=$(find "$ZEVAL_DIR" -name "*.wav" -type f | wc -l)
echo "📊 変換対象: $TOTAL ファイル"
echo ""

# 変換実行
CONVERTED=0
FAILED=0

# カレントディレクトリを変更してから処理
cd "$ZEVAL_DIR"

find . -name "*.wav" -type f | while read -r wav_file; do
    # 相対パスを絶対パスに変換
    abs_path=$(cd "$(dirname "$wav_file")" && pwd)/$(basename "$wav_file")
    rel_path="$wav_file"
    
    echo "🔄 変換中: $rel_path"
    
    # 一時ファイル名
    tmp_file="${abs_path}.tmp.wav"
    
    # ffmpegで変換
    # -ac 1: mono
    # -ar 44100: 44.1kHz
    # -sample_fmt s16: PCM 16-bit
    if ffmpeg -y -i "$abs_path" -ac 1 -ar 44100 -sample_fmt s16 "$tmp_file" -loglevel error 2>&1; then
        # 変換成功: 元ファイルをバックアップして置き換え
        mv "$abs_path" "${abs_path}.bak"
        mv "$tmp_file" "$abs_path"
        echo "  ✅ 完了"
        CONVERTED=$((CONVERTED + 1))
    else
        echo "  ❌ 失敗: $rel_path"
        rm -f "$tmp_file"
        FAILED=$((FAILED + 1))
    fi
done

# カウントを表示（whileループ内の変数は外に出ないので、別途カウント）
cd "$SCRIPT_DIR"

echo ""
echo "============================================================"
echo "✅ 変換完了"
echo "  成功: $CONVERTED ファイル"
echo "  失敗: $FAILED ファイル"
echo ""
echo "📝 バックアップファイル（.bak）は削除して問題ありません:"
echo "   find $ZEVAL_DIR -name '*.bak' -delete"
echo "============================================================"
