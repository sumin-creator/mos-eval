# 🌐 GitHub PagesでWebサイトを公開する手順

## ✅ ステップ1: 変更をpush

```bash
cd /home/sumino/mos-eval
git add .
git commit -m "Update .gitignore to hide audio files"
git push
```

## ✅ ステップ2: GitHub Pagesを有効化（1回だけ）

1. **GitHubでリポジトリを開く**
   - https://github.com/sumin-creator/mos-eval にアクセス

2. **Settings（設定）をクリック**
   - リポジトリページの上部メニューから「Settings」を選択

3. **左メニューから「Pages」を選択**
   - サイドバーの「Pages」をクリック

4. **Source（ソース）を設定**
   - **Branch**: `main` を選択
   - **Folder**: `/ (root)` を選択
   - **Save** ボタンをクリック

5. **完了！**
   - 数秒〜2分待つと、以下のメッセージが表示されます：
   ```
   Your site is live at https://sumin-creator.github.io/mos-eval/
   ```

## ✅ ステップ3: アクセス確認

30秒〜2分後に以下のURLでアクセス可能：

```
https://sumin-creator.github.io/mos-eval/
```

## 🔄 今後の更新方法

コードを変更したら、pushするだけで自動的に反映されます：

```bash
git add .
git commit -m "Update website"
git push
```

→ **数分後に自動で更新されます**（再設定不要）

## ⚠️ 注意事項

- **初回のみ**GitHub Pagesの設定が必要です
- 2回目以降はpushするだけで自動更新されます
- 音声ファイル（`zeval/`）は`.gitignore`で除外されていますが、既にpushされたファイルはGitHub Pagesからアクセス可能です

## 🎯 確認チェックリスト

- [ ] 変更をpushした
- [ ] GitHub Pagesを有効化した
- [ ] URLが表示された
- [ ] サイトが正常に表示される
- [ ] 音声が再生できる

