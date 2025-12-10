#!/bin/bash
# 0111ディレクトリのMP3ファイルを0.1秒短くする臨時スクリプト

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="$SCRIPT_DIR/zeval/0111"
TRIM_DURATION=0.1  # 0.1秒短くする

echo "🎵 0111ディレクトリのMP3ファイルを0.1秒短くします..."
echo ""

# ffmpegの確認
if ! command -v ffmpeg &> /dev/null; then
    echo "❌ エラー: ffmpeg がインストールされていません"
    exit 1
fi

# ディレクトリの確認
if [ ! -d "$TARGET_DIR" ]; then
    echo "❌ エラー: $TARGET_DIR が見つかりません"
    exit 1
fi

cd "$TARGET_DIR"

# MP3ファイルを取得
mp3_files=$(find . -name "*.mp3" -type f | sort)

if [ -z "$mp3_files" ]; then
    echo "❌ MP3ファイルが見つかりません"
    exit 1
fi

echo "📊 処理対象: $(echo "$mp3_files" | wc -l) ファイル"
echo ""

# 各ファイルを処理
for mp3_file in $mp3_files; do
    echo "🔄 処理中: $mp3_file"
    
    # 元のファイル名
    original_file="$mp3_file"
    # 一時ファイル名
    tmp_file="${mp3_file%.mp3}_tmp.mp3"
    
    # ファイルの長さを取得
    duration=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$original_file" 2>/dev/null)
    
    if [ -z "$duration" ]; then
        echo "  ⚠️  長さを取得できませんでした。スキップします。"
        continue
    fi
    
    # 新しい長さを計算（0.1秒短くする）
    new_duration=$(echo "$duration - $TRIM_DURATION" | bc)
    
    if (( $(echo "$new_duration <= 0" | bc -l) )); then
        echo "  ⚠️  ファイルが短すぎます（${duration}秒）。スキップします。"
        continue
    fi
    
    echo "  📏 元の長さ: ${duration}秒 → 新しい長さ: ${new_duration}秒"
    
    # ffmpegで0.1秒短くする（最後から0.1秒を削除）
    if ffmpeg -y -i "$original_file" -t "$new_duration" -acodec copy "$tmp_file" -loglevel error 2>&1; then
        # 成功: 元ファイルをバックアップして置き換え
        mv "$original_file" "${original_file}.old"
        mv "$tmp_file" "$original_file"
        echo "  ✅ 完了"
    else
        echo "  ❌ 失敗: $mp3_file"
        rm -f "$tmp_file"
    fi
done

echo ""
echo "============================================================"
echo "✅ 処理完了"
echo "📝 バックアップファイル（.old）は削除して問題ありません:"
echo "   find $TARGET_DIR -name '*.old' -delete"
echo "============================================================"

