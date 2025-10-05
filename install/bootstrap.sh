#!/usr/bin/env bash
set -euo pipefail

INSTALL_DIR="$HOME/.dotfiles/install"

echo "🚀 Starting system bootstrap..."
echo "--------------------------------"

# Run package installation
bash "$INSTALL_DIR/install-pks.sh"

# Run dotfile linking
bash "$INSTALL_DIR/install-dotfiles.sh"

echo "--------------------------------"
echo "🎉 Bootstrap complete! You can now log out and log back in for Zsh + configs to fully apply."
