#!/usr/bin/env bash
# Usage: app-toggle.sh <class> <command>
# Example: app-toggle.sh firefox firefox

CLASS="$1"
CMD="$2"

# Get list of all client classes (case-insensitive match)
if hyprctl clients | grep -iq "class:.*$CLASS"; then
  # Focus the window if it exists
  TARGET=$(hyprctl clients | grep -i "class:.*$CLASS" | head -n 1 | awk '{print $2}')
  hyprctl dispatch focuswindow "class:$CLASS"
else
  # Otherwise, launch the app
  $CMD &
fi
