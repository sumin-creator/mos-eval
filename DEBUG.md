# 🔧 音声が再生されない場合のデバッグ手順

## ✅ 修正済みの内容

1. **パス修正**: `zeval/${dir}/${file}` に変更（GitHub Pages用）
2. **preload追加**: `<audio preload="auto">` を追加
3. **明示的ロード**: `audioPlayer.load()` を追加
4. **エラーハンドリング**: コンソールにエラーを表示

## 🔍 デバッグ手順

### ① ブラウザで直接アクセス

以下のURLを直接ブラウザで開いてください：

```
https://sumin-creator.github.io/mos-eval/zeval/0105/A.wav
```

**結果**:
- ✅ **再生できる** → HTML/JSの問題（修正済み）
- ❌ **404エラー** → GitHub Pagesが`zeval/`を配信していない
- ❌ **403エラー** → アクセス権限の問題

### ② ブラウザの開発者ツールで確認

1. **F12** を押して開発者ツールを開く
2. **Console（コンソール）**タブを開く
3. ページをリロード
4. エラーメッセージを確認

**確認ポイント**:
- `音声読み込み成功: zeval/0105/A.wav` → 正常
- `音声読み込みエラー: zeval/0105/A.wav` → パスまたはファイルの問題
- `404 Not Found` → GitHub Pagesがファイルを配信していない

### ③ Network（ネットワーク）タブで確認

1. **Network（ネットワーク）**タブを開く
2. ページをリロード
3. `zeval/0105/A.wav` などのリクエストを確認

**確認ポイント**:
- **Status: 200** → 正常に読み込まれている
- **Status: 404** → ファイルが見つからない
- **Status: 403** → アクセス権限がない

## 🛠️ よくある問題と解決方法

### 問題1: GitHub Pagesが`zeval/`を配信していない

**原因**: `.gitignore`で除外されているが、既にpushされたファイルは残っているはず

**解決方法**:
```bash
cd /home/sumino/mos-eval
# zeval/がpushされているか確認
git ls-files | grep zeval

# もし表示されない場合、強制的に追加（.gitignoreを一時的に無効化）
git add -f zeval/
git commit -m "Add audio files for GitHub Pages"
git push
```

### 問題2: MIMEタイプの問題

**原因**: GitHub Pagesが`.wav`ファイルを正しく配信していない

**解決方法**: 
- ブラウザのキャッシュをクリア
- 別のブラウザで試す
- `index.html`に`<meta>`タグを追加（既に含まれている）

### 問題3: パスの問題

**現在の設定**:
```javascript
path: `zeval/${dir}/${file}`
```

**GitHub Pagesでの実際のURL**:
```
https://sumin-creator.github.io/mos-eval/zeval/0105/A.wav
```

✅ これは正しいです。

## 📝 チェックリスト

- [ ] GitHub Pagesが有効化されている（Settings → Pages）
- [ ] `zeval/`フォルダがリポジトリにpushされている
- [ ] 直接URLで音声ファイルにアクセスできる
- [ ] ブラウザのコンソールにエラーがない
- [ ] Networkタブで200ステータスが返っている

## 🎯 次のステップ

修正をpushして確認：

```bash
cd /home/sumino/mos-eval
git add index.html
git commit -m "Fix audio loading: add zeval/ path prefix and explicit load()"
git push
```

→ 数分後にGitHub Pagesに反映されます

