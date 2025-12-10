#!/usr/bin/env python3
"""
WAVファイルをブラウザ対応形式（PCM 16-bit, 44.1kHz, mono）に一括変換
Python版（librosa/soundfile使用）
"""

import os
import sys
from pathlib import Path
import soundfile as sf
import numpy as np

def convert_wav_to_browser_compatible(input_path, output_path=None):
    """
    WAVファイルをブラウザ対応形式に変換
    
    Args:
        input_path: 入力ファイルパス
        output_path: 出力ファイルパス（Noneの場合は上書き）
    
    Returns:
        bool: 変換成功ならTrue
    """
    try:
        # 音声ファイルを読み込み
        audio, sr = sf.read(input_path)
        
        # モノラルに変換（ステレオの場合）
        if len(audio.shape) > 1:
            audio = np.mean(audio, axis=1)
        
        # サンプリングレートを44.1kHzに変換（必要に応じて）
        target_sr = 44100
        if sr != target_sr:
            # librosaが必要な場合はここでリサンプリング
            try:
                import librosa
                audio = librosa.resample(audio, orig_sr=sr, target_sr=target_sr)
                sr = target_sr
            except ImportError:
                print(f"  ⚠️  警告: サンプリングレート変換にはlibrosaが必要です（現在: {sr}Hz）")
        
        # 出力パス
        if output_path is None:
            output_path = input_path
        
        # PCM 16-bitで保存
        sf.write(output_path, audio, sr, subtype='PCM_16')
        
        return True
    except Exception as e:
        print(f"  ❌ エラー: {e}")
        return False

def main():
    script_dir = Path(__file__).parent
    zeval_dir = script_dir / "zeval"
    
    if not zeval_dir.exists():
        print(f"❌ エラー: {zeval_dir} が見つかりません")
        sys.exit(1)
    
    # 全WAVファイルを取得
    wav_files = list(zeval_dir.rglob("*.wav"))
    total = len(wav_files)
    
    print("🎵 WAVファイルをブラウザ対応形式に変換中...")
    print(f"📊 変換対象: {total} ファイル")
    print("")
    
    converted = 0
    failed = 0
    
    for wav_file in wav_files:
        print(f"🔄 変換中: {wav_file}")
        
        # バックアップ
        backup_path = wav_file.with_suffix('.wav.bak')
        try:
            import shutil
            shutil.copy2(wav_file, backup_path)
        except Exception as e:
            print(f"  ⚠️  バックアップ失敗: {e}")
        
        # 変換
        if convert_wav_to_browser_compatible(str(wav_file)):
            print("  ✅ 完了")
            converted += 1
        else:
            # 失敗時はバックアップから復元
            if backup_path.exists():
                backup_path.replace(wav_file)
            print("  ❌ 失敗")
            failed += 1
    
    print("")
    print("=" * 60)
    print("✅ 変換完了")
    print(f"  成功: {converted} ファイル")
    print(f"  失敗: {failed} ファイル")
    print("")
    print("📝 バックアップファイル（.bak）は削除して問題ありません:")
    print(f"   find {zeval_dir} -name '*.bak' -delete")
    print("=" * 60)

if __name__ == "__main__":
    main()

