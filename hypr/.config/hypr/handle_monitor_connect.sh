#!/bin/bash
# Monitor hotplug handler

# Wait for the system to register the monitor properly
sleep 2

# Run the monitor setup script
~/.config/hypr/monitor_setup.sh

# Notify user
notify-send "Monitor Change" "Display configuration updated"
