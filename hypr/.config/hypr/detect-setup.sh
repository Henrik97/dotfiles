#!/bin/bash

# Detect the current setup
get_setup_type() {
  # Check if this is the laptop (you can use hostname, number of monitors, or other identifiers)
  if [[ "$(hostname)" == "work-laptop" ]]; then
    echo "work"
  else
    echo "home"
  fi
}

setup_monitors() {
  local setup_type=$(get_setup_type)

  if [[ "$setup_type" == "work" ]]; then
    # Work setup - laptop with 2 external monitors
    # Get monitor identifiers
    local laptop_monitor=$(hyprctl monitors -j | jq -r '.[] | select(.name | contains("eDP")) .name')
    local external_primary=$(hyprctl monitors -j | jq -r '.[] | select(.name | contains("DP-2")) .name // .[] | select(.name | contains("DP-1")) .name')
    local external_secondary=$(hyprctl monitors -j | jq -r '.[] | select(.name | contains("DP-1")) .name')

    # Configure monitors if they exist
    [[ -n "$laptop_monitor" ]] && echo "monitor=$laptop_monitor,preferred,auto,1,workspace=7"
    [[ -n "$external_primary" ]] && echo "monitor=$external_primary,preferred,auto,1,workspace=1"
    [[ -n "$external_secondary" ]] && echo "monitor=$external_secondary,preferred,auto,1,workspace=2"

    # Workspace assignments for work setup
    echo "workspace=1,monitor:$external_primary"
    echo "workspace=3,monitor:$external_primary"
    echo "workspace=5,monitor:$external_primary"
    echo "workspace=2,monitor:$external_secondary"
    echo "workspace=4,monitor:$external_secondary"
    echo "workspace=6,monitor:$external_secondary"
    echo "workspace=7,monitor:$laptop_monitor"
  else
    # Home setup - desktop with 2 monitors
    local primary=$(hyprctl monitors -j | jq -r '.[0].name')
    local secondary=$(hyprctl monitors -j | jq -r '.[1].name // empty')

    # Configure monitors
    echo "monitor=$primary,preferred,auto,1,workspace=1"
    [[ -n "$secondary" ]] && echo "monitor=$secondary,preferred,auto,1,workspace=2"

    # Workspace assignments for home setup
    echo "workspace=1,monitor:$primary"
    echo "workspace=3,monitor:$primary"
    echo "workspace=5,monitor:$primary"
    echo "workspace=2,monitor:$secondary"
    echo "workspace=4,monitor:$secondary"
    echo "workspace=6,monitor:$secondary"
  fi
}

# Get handle for disconnected monitors
handle_disconnected_monitors() {
  local setup_type=$(get_setup_type)

  if [[ "$setup_type" == "work" ]]; then
    # Ensure laptop monitor gets all workspaces when external monitors are disconnected
    echo "# Handle laptop monitor when external displays disconnected"
    echo 'bind = $mainMod, 1, workspace, 1'
    echo 'bind = $mainMod, 2, workspace, 2'
    echo 'bind = $mainMod, 3, workspace, 3'
    echo 'bind = $mainMod, 4, workspace, 4'
    echo 'bind = $mainMod, 5, workspace, 5'
    echo 'bind = $mainMod, 6, workspace, 6'
    echo 'bind = $mainMod, 7, workspace, 7'
  fi
}
