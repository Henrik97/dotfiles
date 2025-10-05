#!/usr/bin/env bash
#!/usr/bin/env bash
set -euo pipefail

PKG_DIR="$HOME/.dotfiles/meta/packages"

echo "📦 Installing system packages..."

# Install official packages
if [[ -f "$PKG_DIR/pacman.txt" ]]; then
  echo "➡️  Installing pacman packages..."
  grep -v '^#' "$PKG_DIR/pacman.txt" | xargs sudo pacman -S --needed --noconfirm
fi

# Install yay (AUR helper) if missing
if ! command -v yay &>/dev/null; then
  echo "➡️  Installing yay..."
  sudo pacman -S --needed --noconfirm git base-devel
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  (cd /tmp/yay && makepkg -si --noconfirm)
  rm -rf /tmp/yay
fi

# Install AUR packages
if [[ -f "$PKG_DIR/aur.txt" ]]; then
  echo "➡️  Installing AUR packages..."
  yay -S --needed --noconfirm - <"$PKG_DIR/aur.txt"
fi

echo "✅ Package installation complete."
