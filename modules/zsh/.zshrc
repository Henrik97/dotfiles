# =====================================
# Zsh Configuration — Henrik's Setup
# =====================================

# --- Environment ---
export EDITOR='nvim'
export TERM="xterm-256color"
export ZSH_DISABLE_COMPFIX=true

# --- PATH ---
export PATH="$HOME/.local/bin:$HOME/bin:/usr/local/bin:$PATH"

# --- Plugin manager: zinit (fast, minimal) ---
if [[ ! -f ~/.local/share/zinit/zinit.zsh ]]; then
  mkdir -p ~/.local/share/zinit
  git clone https://github.com/zdharma-continuum/zinit.git ~/.local/share/zinit/bin
fi
source ~/.local/share/zinit/bin/zinit.zsh

# --- Plugins ---
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light Aloxaf/fzf-tab
zinit light hlissner/zsh-autopair

# --- Prompt ---
eval "$(starship init zsh)"

# --- Navigation & fuzzy search ---
eval "$(zoxide init zsh)"
source <(fzf --zsh)
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --preview 'bat --color=always {}'"

# --- Aliases ---
alias reload-zsh="source ~/.zshrc"
alias edit-zsh="nvim ~/.zshrc"

# Better ls
alias ls="eza --icons=always"
alias ll="eza -l --git --icons"

# Lazy tools
alias lg="lazygit"
alias ld="lazydocker"

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

# --- Finish ---
echo "🐚 Zsh loaded with zinit, starship, zoxide, and fzf"

