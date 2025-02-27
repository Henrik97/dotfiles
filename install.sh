#!/usr/bin/env bash
set -euo pipefail
# Install yay (AUR helper) if not present
install_yay() {
	if ! command -v yay &>/dev/null; then
		echo "Installing yay..."
		sudo pacman -S --needed git base-devel
		git clone https://aur.archlinux.org/yay.git /tmp/yay
		(cd /tmp/yay && makepkg -si)
	fi
}
install_native_pkgs() {
	echo "Installing official packages..."
	# Read packages from file, installing one by one to prevent full failure
	while read pkg; do
		# Skip empty lines and comments
		[[ -z "$pkg" || "$pkg" =~ ^# ]] && continue
		echo "Installing $pkg..."
		sudo pacman -S --needed --noconfirm "$pkg" || echo "Failed to install $pkg, continuing..."
	done <pkglist/native.list
}

install_aur_pkgs() {
	echo "Installing AUR packages..."
	yay -S --needed - <pkglist/aur.list
}
# In install.sh
check_pkglist_format() {
	if grep -q '^base$\|^base-devel$' pkglist/native.list; then
		echo "Warning: base packages should not be in native.list"
		exit 1
	fi
}
# Run before installation
check_pkglist_format

# --- Main installation flow ---
install_yay
install_native_pkgs
install_aur_pkgs
# Install core packages
sudo pacman -S --needed \
	zsh \
	starship \
	eza \
	ranger \
	ripgrep \
	fzf \
	zoxide

# Install AUR packages
yay -S \
	thefuck

# Install Oh My Zsh (non-interactive)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install plugins
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"
plugins=(
	"https://github.com/zsh-users/zsh-autosuggestions"
	"https://github.com/zsh-users/zsh-syntax-highlighting"
)
for plugin in "${plugins[@]}"; do
	repo_name=$(basename "$plugin")
	[ ! -d "$ZSH_CUSTOM/$repo_name" ] && git clone "$plugin" "$ZSH_CUSTOM/$repo_name"
done

# Configure fzf key bindings
$(which fzf) --install

# Symlink dotfiles (using GNU Stow)
stow -v --target=$HOME zsh starship

# Set Zsh as default shell
[ "$SHELL" != "$(command -v zsh)" ] && sudo chsh -s $(which zsh) $USER
