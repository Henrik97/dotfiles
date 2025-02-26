#!/bin/bash
# This script fetches the active window title using hyprctl.
hyprctl activewindow | grep "title:" | cut -d':' -f2 | sed 's/^[ \t]*//'
