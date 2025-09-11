#!/bin/bash
# Handle monitor reconnection

# Wait for system to stabilize
sleep 5

# Regenerate configuration
~/.config/hypr/generate_monitor_config.sh

# Force configuration reload
hyprctl reload

# Notify user
notify-send "Monitor Configuration" "Display setup has been updated"
