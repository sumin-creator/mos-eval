# MOS評価システム

GitHub Pagesで動作する音質評価（MOS: Mean Opinion Score）システムです。

## 🚀 使い方

### 1. リポジトリにpush

```bash
cd /home/sumino/mos-eval
git init
git add .
git commit -m "mos evaluation site"
git remote add origin https://github.com/YOUR_USERNAME/mos-eval.git
git push -u origin main
```

### 2. GitHub Pagesを有効化

1. GitHubでリポジトリを開く
2. **Settings** → **Pages**
3. **Source**: `main` ブランチ、`/ (root)` フォルダ
4. **Save**

### 3. アクセス

30秒〜2分後に以下のURLでアクセス可能：

```
https://YOUR_USERNAME.github.io/mos-eval/
```

## 📁 ディレクトリ構造

```
mos-eval/
├── index.html          # メインのHTMLファイル
├── README.md           # このファイル
└── zeval/              # 音声ファイル（GitHubにpushする必要あり）
    ├── 0105/
    │   ├── A.wav
    │   ├── B.wav
    │   ├── C.wav
    │   ├── D.wav
    │   └── E.wav
    ├── 0107/
    └── ...
```

## ⚠️ 重要: 音声ファイルの配置

`index.html`と同じディレクトリに`zeval`フォルダを配置してください。

または、`index.html`の音声パスを修正：

```javascript
// 現在
path: `${dir}/${file}`

// カスタムパスの場合
path: `https://raw.githubusercontent.com/USER/mos-eval/main/zeval/${dir}/${file}`
```

## ✨ 機能

- ✅ ランダム順序で音声を提示
- ✅ 1-5のMOSスコア評価
- ✅ 進捗の自動保存（ローカルストレージ）
- ✅ CSV形式で結果をダウンロード
- ✅ レスポンシブデザイン

## 📊 結果の形式

CSVファイルには以下の情報が含まれます：

- ディレクトリ名
- ファイル名
- ラベル
- 評価スコア（1-5）
- タイムスタンプ

## 🔧 カスタマイズ

### 音声ファイルの追加/削除

`index.html`の`audioFiles`配列を編集：

```javascript
const audioFiles = [
    { dir: '0105', files: ['A.wav', 'B.wav', 'C.wav', 'D.wav', 'E.wav'] },
    // 追加・削除・変更可能
];
```

### スタイルの変更

`<style>`タグ内のCSSを編集してください。

## 📝 ライセンス

MIT License

