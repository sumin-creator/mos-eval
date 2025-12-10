#!/bin/bash
# WAVファイルをブラウザ対応形式（PCM 16-bit, 44.1kHz, mono）に一括変換

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ZEVAL_DIR="$SCRIPT_DIR/zeval"

echo "🎵 WAVファイルをブラウザ対応形式に変換中..."
echo ""

# ffmpegの確認
if ! command -v ffmpeg &> /dev/null; then
    echo "❌ エラー: ffmpeg がインストールされていません"
    exit 1
fi

cd "$ZEVAL_DIR"

CONVERTED=0
FAILED=0
SKIPPED=0

for wav_file in $(find . -name "*.wav" -type f | sort); do
    # バックアップファイルはスキップ
    if [[ "$wav_file" == *.bak ]]; then
        continue
    fi
    
    # 既に変換済みかチェック（バックアップがある場合）
    if [ -f "${wav_file}.bak" ]; then
        echo "⏭️  スキップ（既に変換済み）: $wav_file"
        ((SKIPPED++))
        continue
    fi
    
    echo "🔄 変換中: $wav_file"
    
    # 一時ファイル名（.wav拡張子を保持）
    tmp_file="${wav_file%.wav}_tmp.wav"
    
    # ffmpegで変換
    # -ac 1: mono
    # -ar 44100: 44.1kHz
    # -sample_fmt s16: PCM 16-bit
    if ffmpeg -y -i "$wav_file" -ac 1 -ar 44100 -sample_fmt s16 "$tmp_file" -loglevel error 2>&1; then
        # 変換成功: 元ファイルをバックアップして置き換え
        mv "$wav_file" "${wav_file}.bak"
        mv "$tmp_file" "$wav_file"
        echo "  ✅ 完了"
        ((CONVERTED++))
    else
        echo "  ❌ 失敗: $wav_file"
        rm -f "$tmp_file"
        ((FAILED++))
    fi
done

echo ""
echo "============================================================"
echo "✅ 変換完了"
echo "  成功: $CONVERTED ファイル"
echo "  失敗: $FAILED ファイル"
echo "  スキップ: $SKIPPED ファイル"
echo "============================================================"

