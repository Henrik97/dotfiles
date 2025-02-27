#!/bin/bash

# Install pacman packages
sudo pacman -S --needed - < pacman-pkgs.txt

# Install yay if not already installed
if ! command -v yay &> /dev/null; then
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si --noconfirm
  cd ..
  rm -rf yay
fi

# Install AUR packages
yay -S --needed - < aur-pkgs.txt

# Set Zsh as default shell
sudo chsh -s "$(which zsh)" "$USER"
