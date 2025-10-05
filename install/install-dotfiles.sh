#!/usr/bin/env bash
set -euo pipefail

MODULE_DIR="$HOME/.dotfiles/modules"

echo "🔗 Linking dotfiles with stow..."

cd "$MODULE_DIR"
stow -v --target="$HOME" zsh starship tmux kitty hypr waybar wofi walker scripts

# Set zsh as the default shell
if [[ "$SHELL" != "$(which zsh)" ]]; then
  echo "⚙️  Setting Zsh as default shell..."
  sudo chsh -s "$(which zsh)" "$USER"
fi

echo "✅ Dotfiles linked successfully!"
