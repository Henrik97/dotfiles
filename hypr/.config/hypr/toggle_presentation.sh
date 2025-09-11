#!/bin/bash
# Toggle between normal and presentation mode for screen sharing

if [[ -f ~/.config/hypr/.presentation_mode ]]; then
  # Exit presentation mode - restore normal config
  rm ~/.config/hypr/.presentation_mode
  
  # Reset monitors to normal configuration
  hyprctl keyword monitor eDP-1,1920x1200@60,0x0,1.5
  hyprctl keyword monitor DP-2,3840x2160@60,1920x0,1.5
  hyprctl keyword monitor DP-1,2560x1440@60,5760x0,1.0
  
  # Restore workspace assignments
  hyprctl keyword workspace 1,monitor:DP-2
  hyprctl keyword workspace 3,monitor:DP-2
  hyprctl keyword workspace 5,monitor:DP-2
  
  hyprctl keyword workspace 2,monitor:DP-1
  hyprctl keyword workspace 4,monitor:DP-1
  hyprctl keyword workspace 6,monitor:DP-1
  
  hyprctl keyword workspace 7,monitor:eDP-1
  hyprctl keyword workspace 8,monitor:eDP-1
  hyprctl keyword workspace 9,monitor:eDP-1
  
  notify-send "Normal Mode" "Restored regular monitor configuration"
else
  # Enter presentation mode - optimize for screen sharing
  touch ~/.config/hypr/.presentation_mode
  
  # Make laptop display primary and set scale for better visibility
  hyprctl keyword monitor eDP-1,1920x1200@60,0x0,1.25
  
  # Move all workspaces to laptop display
  for i in {1..9}; do
    hyprctl keyword workspace $i,monitor:eDP-1
  done
  
  # Switch to workspace 1 on laptop
  hyprctl dispatch workspace 1
  
  notify-send "Presentation Mode" "All workspaces moved to laptop display"
fi
