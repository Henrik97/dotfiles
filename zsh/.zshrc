# =====================================
# Zsh Configuration — Henrik's Setup
# =====================================

# --- Environment ---
export EDITOR='nvim'
export TERM="xterm-256color"
export ZSH_DISABLE_COMPFIX=true

# --- PATH ---
export PATH="$HOME/.local/bin:$HOME/bin:/usr/local/bin:$PATH"

# Load zinit plugin manager
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [[ ! -d "$ZINIT_HOME" ]]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"


# --- Plugins ---
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light Aloxaf/fzf-tab
zinit light hlissner/zsh-autopair

# --- Prompt ---
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
eval "$(starship init zsh)"

# --- Navigation & fuzzy search ---
eval "$(zoxide init zsh)"
source <(fzf --zsh)
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --preview 'bat --color=always {}'"

# --- Aliases ---
alias reload-zsh="source ~/.zshrc"
alias edit-zsh="nvim ~/.zshrc"
alias n="nvim"

# Better ls
alias ls="eza --icons=always"
alias ll="eza -l --git --icons"

# Lazy tools
alias lg="lazygit"
alias ld="lazydocker"


# Smarter 'cd' that uses zoxide first, then normal cd
cd() {
  if [[ "$#" -eq 0 ]]; then
    builtin cd ~
  elif zoxide query "$@" >/dev/null 2>&1; then
    zoxide query "$@" | read -r target && builtin cd "$target"
  else
    builtin cd "$@"
  fi
}

# Quick navigation
alias cdf='cd $(fd --type d | fzf --height 40% --layout=reverse --border)'
alias zf='cd $(zoxide query -l | fzf --height 40% --layout=reverse --border)'

# Ripgrep helpers
alias rgsearch='rg --hidden --glob "!.git"'
alias rgf='rg --files | fzf --height 40% --layout=reverse --border --preview "bat --color=always {}"'
alias rgfr='ranger $(rg --files | fzf --height 40% --layout=reverse --border --preview "bat --color=always {}")'

# Neovim fuzzy open
alias vimf='nvim $(fd --type f | fzf --height 40% --layout=reverse --border --preview "bat --color=always {}")'
alias vimg='nvim $(rg --files | fzf --height 40% --layout=reverse --border --preview "bat --color=always {}")'
alias inv='nvim $(fzf --height 40% --layout=reverse --border --preview "bat --color=always {}")'

# File explorer
alias r='ranger'

# --- Git shortcuts ---
alias gst='git status'
alias gl='git pull'
alias gp='git push'
alias gc='git commit'
alias gca='git commit --amend'
alias gco='git checkout'
alias gb='git branch'
alias gd='git diff'

# --- SSH agent ---
eval "$(ssh-agent -s)" > /dev/null
ssh-add ~/.ssh/id_ed25519 2>/dev/null

# --- AWS profile (optional) ---
export AWS_PROFILE=dev

# --- Misc utilities ---
alias fuck='thefuck'
eval $(thefuck --alias fk)

# --- History settings ---
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_DUPS SHARE_HISTORY

# --- Completion setup ---
autoload -Uz compinit && compinit
autoload -Uz bashcompinit && bashcompinit
zstyle ':completion:*' menu select

