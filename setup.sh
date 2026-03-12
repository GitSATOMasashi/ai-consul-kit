#!/bin/bash
set -e

REPO_URL="https://github.com/GitSATOMasashi/ai-consul-kit.git"
REPO_DIR="ai-consul-kit"

echo ""
echo "==================================="
echo "  ai-consul-kit セットアップ"
echo "==================================="
echo ""

# --- Xcode Command Line Tools ---
if ! xcode-select -p &>/dev/null; then
  echo "[1/5] Xcode Command Line Tools をインストールしています..."
  echo "      ポップアップが表示されたら「インストール」をクリックしてください。"
  xcode-select --install
  echo ""
  echo "      インストールが完了するまで待ってから、"
  echo "      もう一度このコマンドを実行してください。"
  echo ""
  exit 0
else
  echo "[1/5] Xcode Command Line Tools ... OK"
fi

# --- Homebrew ---
if ! command -v brew &>/dev/null; then
  echo "[2/5] Homebrew をインストールしています..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Apple Silicon Mac の場合、PATH を通す
  if [ -f /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  fi
else
  echo "[2/5] Homebrew ... OK"
fi

# --- GitHub CLI ---
if ! command -v gh &>/dev/null; then
  echo "[3/5] GitHub CLI をインストールしています..."
  brew install gh
else
  echo "[3/5] GitHub CLI ... OK"
fi

# --- GitHub 認証 ---
if ! gh auth status &>/dev/null; then
  echo "[4/5] GitHub にログインします。ブラウザが開くので、ログインしてください。"
  gh auth login --web --git-protocol https
  gh auth setup-git
else
  echo "[4/5] GitHub 認証 ... OK"
fi

# --- Clone ---
if [ -d "$REPO_DIR" ]; then
  echo "[5/5] $REPO_DIR は既に存在します。最新版に更新します..."
  cd "$REPO_DIR" && git pull && cd ..
else
  echo "[5/5] リポジトリをダウンロードしています..."
  git clone "$REPO_URL"
fi

echo ""
echo "==================================="
echo "  セットアップ完了！"
echo "==================================="
echo ""
echo "次のステップ:"
echo "  1. Cursor のメニューから「ファイル → フォルダーを開く」"
echo "  2. 今いるフォルダの中の「$REPO_DIR」を選択"
echo "  3. チャット欄に「こんにちは」と送ってみてください"
echo ""
