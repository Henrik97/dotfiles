#!/usr/bin/env bash
# Starts a new tmux session with nvim, lazygit, and lazydocker

SESSION=${1:-dev}
PATH_TO_DIR=$(pwd)

# If the session already exists, just attach
if tmux has-session -t "$SESSION" 2>/dev/null; then
  tmux attach -t "$SESSION"
  exit 0
fi

# Create a new detached session
tmux new-session -d -s "$SESSION" -c "$PATH_TO_DIR" "nvim ."

# Create additional windows
tmux new-window -t "$SESSION":2 -n "git" -c "$PATH_TO_DIR" "lazygit"
tmux new-window -t "$SESSION":3 -n "docker" -c "$PATH_TO_DIR" "lazydocker"

# Kill empty shell windows (if any)
tmux kill-window -t "$SESSION":0 2>/dev/null

# Attach to session
tmux attach -t "$SESSION"
