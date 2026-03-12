#!/bin/bash
set -e

REPO_URL="https://github.com/GitSATOMasashi/ai-consul-kit.git"
REPO_DIR="ai-consul-kit"

echo ""
echo "==================================="
echo "  ai-consul-kit セットアップ"
echo "==================================="
echo ""
echo "これから必要なツールを順番にインストールしていきます。"
echo "途中で操作が必要な場面がありますが、画面の指示に従えば大丈夫です。"
echo ""

# =========================================
# ステップ 1/5: Xcode Command Line Tools
# =========================================
echo "-------------------------------------------"
echo "  ステップ 1/5: 開発ツールの準備"
echo "-------------------------------------------"
echo ""

if ! xcode-select -p &>/dev/null; then
  echo "  開発に必要な基本ツールをインストールします。"
  echo ""
  echo "  >>> ポップアップが表示されたら「インストール」をクリックしてください。"
  echo "  >>> インストールには 5〜10分 かかります。そのままお待ちください。"
  echo ""
  xcode-select --install
  echo ""
  echo "  =========================================================="
  echo "  インストールが完了したら、もう一度、最初のコマンドを"
  echo "  ターミナルにコピー＆ペーストして実行してください。"
  echo "  =========================================================="
  echo ""
  exit 0
else
  echo "  開発ツール ... インストール済みです。OK!"
  echo ""
fi

# =========================================
# ステップ 2/5: Homebrew
# =========================================
echo "-------------------------------------------"
echo "  ステップ 2/5: Homebrew のインストール"
echo "-------------------------------------------"
echo ""
echo "  Homebrew は、ツールを簡単にインストールするための仕組みです。"
echo ""

if ! command -v brew &>/dev/null; then
  echo "  これから Homebrew をインストールします。"
  echo ""
  echo "  >>> パスワードを求められたら:"
  echo "      Mac のログインパスワードを入力してください。"
  echo "      （文字は表示されませんが、入力されています。そのまま Enter を押してください）"
  echo ""
  echo "  >>> 「Press RETURN/ENTER to continue」と表示されたら:"
  echo "      そのまま Enter を押してください。"
  echo ""
  echo "  >>> インストールには数分かかります。そのままお待ちください。"
  echo ""
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  if [ -f /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  fi

  echo ""
  echo "  Homebrew のインストールが完了しました!"
  echo ""
else
  echo "  Homebrew ... インストール済みです。OK!"
  echo ""
fi

# =========================================
# ステップ 3/5: GitHub CLI
# =========================================
echo "-------------------------------------------"
echo "  ステップ 3/5: GitHub CLI のインストール"
echo "-------------------------------------------"
echo ""
echo "  GitHub CLI は、GitHub と連携するためのツールです。"
echo ""

if ! command -v gh &>/dev/null; then
  echo "  インストールしています... 自動で終わるのでそのままお待ちください。"
  echo ""
  brew install gh
  echo ""
  echo "  GitHub CLI のインストールが完了しました!"
  echo ""
else
  echo "  GitHub CLI ... インストール済みです。OK!"
  echo ""
fi

# =========================================
# ステップ 4/5: GitHub 認証
# =========================================
echo "-------------------------------------------"
echo "  ステップ 4/5: GitHub にログイン"
echo "-------------------------------------------"
echo ""

if ! gh auth status &>/dev/null; then
  echo "  GitHub アカウントにログインします。"
  echo ""
  echo "  >>> これからブラウザが自動で開きます。"
  echo "  >>> GitHub にログインしてください。"
  echo "      （アカウントがない場合は、画面の指示に従って作成してください）"
  echo ""
  echo "  >>> ターミナルに 8桁のコード が表示された場合は、"
  echo "      ブラウザの画面にそのコードを入力してください。"
  echo ""
  echo "  >>> ブラウザで「Authorize」ボタンを押してください。"
  echo "  >>> 認証が終わると、自動でターミナルに戻ります。"
  echo ""
  gh auth login --web --git-protocol https
  gh auth setup-git
  echo ""
  echo "  GitHub へのログインが完了しました!"
  echo ""
else
  echo "  GitHub 認証 ... ログイン済みです。OK!"
  echo ""
fi

# =========================================
# ステップ 5/5: リポジトリのダウンロード
# =========================================
echo "-------------------------------------------"
echo "  ステップ 5/5: ai-consul-kit のダウンロード"
echo "-------------------------------------------"
echo ""

if [ -d "$REPO_DIR" ]; then
  echo "  $REPO_DIR は既に存在します。最新版に更新しています..."
  cd "$REPO_DIR" && git pull && cd ..
  echo ""
  echo "  更新が完了しました!"
  echo ""
else
  echo "  ダウンロードしています... 数秒で終わります。"
  echo ""
  git clone "$REPO_URL"
  echo ""
  echo "  ダウンロードが完了しました!"
  echo ""
fi

# =========================================
# 完了
# =========================================
echo ""
echo "==================================="
echo "  セットアップ完了！"
echo "==================================="
echo ""
echo "  次のステップ:"
echo "    1. Cursor のメニューから「ファイル → フォルダーを開く」"
echo "    2. 今いるフォルダの中の「$REPO_DIR」フォルダを選択"
echo "    3. チャット欄に「こんにちは」と送ってみてください"
echo ""
