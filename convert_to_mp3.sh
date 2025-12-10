#!/bin/bash
# WAVファイルをMP3に変換（Edge対応のため）
# MP3は全てのブラウザで確実に再生可能

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ZEVAL_DIR="$SCRIPT_DIR/zeval"

echo "🎵 WAVファイルをMP3に変換中（Edge対応）..."
echo ""

# ffmpegの確認
if ! command -v ffmpeg &> /dev/null; then
    echo "❌ エラー: ffmpeg がインストールされていません"
    exit 1
fi

cd "$ZEVAL_DIR"

CONVERTED=0
FAILED=0

for wav_file in $(find . -name "*.wav" -type f | sort); do
    mp3_file="${wav_file%.wav}.mp3"
    
    echo "🔄 変換中: $wav_file → $mp3_file"
    
    # ffmpegでMP3に変換
    # -ac 1: mono
    # -ar 44100: 44.1kHz
    # -b:a 128k: ビットレート128kbps（高品質）
    if ffmpeg -y -i "$wav_file" -ac 1 -ar 44100 -b:a 128k "$mp3_file" -loglevel error 2>&1; then
        echo "  ✅ 完了"
        ((CONVERTED++))
    else
        echo "  ❌ 失敗: $wav_file"
        ((FAILED++))
    fi
done

echo ""
echo "============================================================"
echo "✅ 変換完了"
echo "  成功: $CONVERTED ファイル"
echo "  失敗: $FAILED ファイル"
echo ""
echo "📝 次のステップ:"
echo "  1. index.htmlのaudioFiles配列を更新（.wav → .mp3）"
echo "  2. git add zeval/*.mp3"
echo "  3. git commit -m 'Add MP3 files for Edge compatibility'"
echo "  4. git push"
echo "============================================================"

