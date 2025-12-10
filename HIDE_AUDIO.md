# 音声ファイルの非表示設定

## 📋 現在の状態

- ✅ `zeval/`フォルダは`.gitignore`で除外されています
- ✅ GitHubのWebインターフェースでは表示されません
- ✅ GitHub Pagesからは`index.html`経由でアクセス可能です

## 🔧 既存ファイルを削除する場合

既にpushされた`zeval/`フォルダをGitの追跡から外すには：

```bash
cd /home/sumino/mos-eval
git rm -r --cached zeval/
git commit -m "Hide audio files from repository view"
git push
```

**注意**: この操作後も、GitHub Pagesからは音声ファイルにアクセスできます（既にpushされたファイルは残ります）。

## ✅ 確認方法

1. **GitHubのWebインターフェース**: `zeval/`フォルダは表示されない
2. **GitHub Pages**: `https://sumin-creator.github.io/mos-eval/` で音声が再生できる
3. **直接URL**: `https://sumin-creator.github.io/mos-eval/zeval/0105/A.wav` にアクセス可能（ただし、URLを知らなければ見つけられない）

## 🎯 結論

現在の設定で問題ありません：
- GitHubのリポジトリページでは`zeval/`は見えない
- GitHub Pagesからは`index.html`経由で音声が使える
- ディレクトリ一覧は自動生成されないので、直接URLを知らなければ見つけられない

