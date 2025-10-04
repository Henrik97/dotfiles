#!/usr/bin/env bash
# Usage: app-toggle.sh <class> <command>

CLASS="$1"
CMD="$2"

if hyprctl clients | grep -q "$CLASS"; then
  hyprctl dispatch focuswindow "class:$CLASS"
else
  $CMD &
fi
