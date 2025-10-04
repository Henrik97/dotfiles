# 🧰 Henrik’s Dotfiles

A modular, reproducible setup for **Arch Linux + Hyprland**, managed with **GNU Stow** and clean install scripts.

---

## 📁 Repository Structure

```
~/.dotfiles/
│
├── install/                 # Installation scripts
│   ├── install-pks.sh       # System setup (pacman + AUR packages)
│   ├── install-dotfiles.sh  # User config setup via Stow
│   └── bootstrap.sh         # Master script that runs everything
│
├── meta/
│   └── packages/
│       ├── pacman.txt       # Official Arch packages
│       └── aur.txt          # AUR packages
│
├── modules/                 # Individual configuration modules
│   ├── hypr/                # Hyprland configuration
│   ├── waybar/              # Waybar status bar
│   ├── kitty/               # Kitty terminal
│   ├── tmux/                # Tmux sessions
│   ├── zsh/                 # Zsh shell setup (zinit, fzf, zoxide, etc.)
│   ├── starship/            # Starship prompt configuration
│   ├── scripts/             # Utility scripts (app toggle, screenshots, etc.)
│   ├── walker/              # Launcher configuration
│   └── wofi/                # Wofi launcher setup
│
├── host/                    # Host-specific overrides (e.g., monitor configs)
├── .stow-local-ignore       # Files excluded from Stow
└── README.md
```

---

## ⚙️ Installation Overview

Your setup uses a **two-step process** for clarity and modularity:

| Script | Purpose |
|:-------|:---------|
| `install/install-pks.sh` | Installs all system and AUR packages |
| `install/install-dotfiles.sh` | Links configs via GNU Stow & sets up Zsh |
| `install/bootstrap.sh` | Runs both scripts automatically |

---

## 🧱 Step 1 — System Setup

Installs all required packages for **Arch Linux** and **Hyprland**:

```bash
cd ~/.dotfiles/install
./install-pks.sh
```

This will install everything listed in:

- `meta/packages/pacman.txt`
- `meta/packages/aur.txt`

If `yay` (AUR helper) is not installed, it will be automatically built and configured.

---

## 🧩 Step 2 — Dotfile Setup

Links configuration files to your home directory using **GNU Stow**:

```bash
./install-dotfiles.sh
```

This links modules like:

- `zsh`, `starship`, `fzf`, `zoxide`, `thefuck`
- `hyprland`, `waybar`, `wofi`, `walker`
- `kitty`, `tmux`, and custom scripts under `~/.config/hypr/scripts`

After installation, your shell will be switched to **Zsh** automatically.

---

## 🚀 Step 3 — Bootstrap (Full Setup)

To run everything in one go:

```bash
./bootstrap.sh
```

This performs:
1. Full package installation (system + AUR)
2. Dotfile linking via Stow
3. Shell setup and cleanup

> 🔁 **After bootstrap**, log out and back in for all changes to apply.

---

## 💻 Reinstalling on a New Machine

On a fresh **Arch install**, follow these steps:

```bash
# 1. Install the basics
sudo pacman -S git stow

# 2. Clone the dotfiles
git clone https://github.com/<your-username>/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles/install

# 3. Run the full setup
chmod +x bootstrap.sh
./bootstrap.sh
```

Your entire environment — shell, Hyprland config, and tools — will be restored automatically.

---

## 🔁 Updating Your Setup

You can safely re-run the bootstrap anytime to update configs or packages:

```bash
~/.dotfiles/install/bootstrap.sh
```

If new entries are added to `pacman.txt` or `aur.txt`, they’ll be installed automatically.

---

## 🧩 Managing Modules

Each configuration module is **independent** and can be stowed or unstowed individually:

```bash
cd ~/.dotfiles/modules
stow -v hypr
stow -D hypr
```

> 🪄 Tip: Use this when testing a single module or syncing new configs.

---

## 🧠 Hyprland Notes

- Host-specific Hyprland configs are loaded automatically from:  
  `~/.config/hypr/host/$(hostname).conf`
- Custom scripts (like app-toggle, brightness, screenshots) are stored under:  
  `~/.config/hypr/scripts/`

---

## ⚡️ Common Shortcuts

| Action | Shortcut |
|:--|:--|
| Launch terminal | `Super + Enter` |
| App launcher | `Super + Space` |
| Settings launcher | `Super + Alt + Space` |
| LazyGit | `Super + G` |
| LazyDocker | `Super + D` |
| Quick edit (nvim .) | `Super + E` |
| Full dev session (tmux + nvim + lazygit + lazydocker) | `Super + Shift + E` |
| Screenshot (copy) | `Print` |
| Screenshot (region to file + swappy) | `Super + Shift + Print` |

---

## 🧰 Tooling Highlights

- **Shell:** `zsh` + `zinit` + `starship`
- **Window Manager:** Hyprland
- **Launcher:** Wofi / Walker
- **Terminal:** Kitty + Tmux
- **Fuzzy tools:** fzf / zoxide / ripgrep / fd / bat / eza
- **Dev tools:** lazygit / lazydocker / docker-compose
- **Audio/Video:** PipeWire + WirePlumber
- **Screenshots:** Grim / Slurp / Swappy / Hyprshot
- **Notifications:** Mako
- **Fonts:** JetBrains Mono Nerd / FiraCode Nerd / Noto Emoji

---

## 🧹 Maintenance Tips

- Keep your packages up to date:
  ```bash
  yay -Syu
  ```
- Check symlinks after major config changes:
  ```bash
  cd ~/.dotfiles/modules
  stow -v --restow *
  ```
- Verify scripts are executable:
  ```bash
  chmod +x ~/.config/hypr/scripts/*.sh
  ```

---

## 🏁 Final Notes

Your dotfile setup is:
- Modular 🧩 — each part can be toggled independently  
- Reproducible 🌀 — installable from scratch in minutes  
- Minimal yet complete 💪 — perfect balance of performance and productivity  

> ✨ _“Automate the boring parts, perfect the rest.”_
