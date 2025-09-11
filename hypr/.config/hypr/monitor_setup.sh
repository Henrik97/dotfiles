#!/bin/bash
# Direct Hyprland Monitor Configuration
# This script generates a complete monitors.conf file with explicit settings

# First, detect all monitors
monitors=$(hyprctl monitors -j)
echo "Generating configuration for monitors: $monitors"

# Determine if this is work or home setup
if [[ "$(hostname)" == "work-laptop" || $(echo "$monitors" | grep -i "edp") ]]; then
  # Work setup (laptop)
  echo "Configuring work setup..."

  # Create a comprehensive monitors.conf file
  cat >~/.config/hypr/monitors.conf <<EOF
# Monitor configuration for work setup
# Generated on $(date)

# Monitor definitions with explicit positions
monitor = eDP-1,1920x1200@60,0x0,1.0
monitor = DP-2,3840x2160@60,1920x0,1.5
monitor = DP-1,2560x1440@60,5760x0,1.2

# Workspace assignments - main external monitor (DP-2)
workspace = 1, monitor:DP-2
workspace = 3, monitor:DP-2
workspace = 5, monitor:DP-2

# Workspace assignments - secondary external monitor (DP-1)
workspace = 2, monitor:DP-1
workspace = 4, monitor:DP-1
workspace = 6, monitor:DP-1

# Workspace assignments - laptop screen
workspace = 7, monitor:eDP-1
workspace = 8, monitor:eDP-1
workspace = 9, monitor:eDP-1

# Add popup window handling
windowrulev2 = float, class:^(*)$, title:^(Popup|Dialog)$
windowrulev2 = center, class:^(*)$, title:^(Popup|Dialog)$
windowrulev2 = size 400 300, class:^(*)$, title:^(Popup|Dialog)$


# Presentation mode toggle for screen sharing
bind = SUPER SHIFT, P, exec, ~/.config/hypr/toggle_presentation.sh
EOF

  # Create presentation mode toggle script
  cat >~/.config/hypr/toggle_presentation.sh <<'EOF'
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
EOF
  chmod +x ~/.config/hypr/toggle_presentation.sh

else
  # Home setup
  echo "Configuring home setup..."

  # Create a comprehensive monitors.conf file for home
  cat >~/.config/hypr/monitors.conf <<EOF
# Monitor configuration for home setup
# Generated on $(date)

# Monitor definitions with explicit positions
monitor = DP-2,2560x1440@60,0x0,1
monitor = HDMI-A-1,1920x1080@60,2560x0,1

# Workspace assignments - main monitor
workspace = 1, monitor:DP-2
workspace = 3, monitor:DP-2
workspace = 5, monitor:DP-2
workspace = 7, monitor:DP-2
workspace = 9, monitor:DP-2

# Workspace assignments - secondary monitor
workspace = 2, monitor:HDMI-A-1
workspace = 4, monitor:HDMI-A-1
workspace = 6, monitor:HDMI-A-1
workspace = 8, monitor:HDMI-A-1

# Fallback rules in case monitors are disconnected
windowrulev2 = workspace 1, class:.*
windowrulev2 = workspace 2, class:.*
EOF

fi

# Create a monitor reconnection handler
cat >~/.config/hypr/monitor_reconnect.sh <<'EOF'
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
EOF
chmod +x ~/.config/hypr/monitor_reconnect.sh

# Add monitor detection to monitors.conf
cat >>~/.config/hypr/monitors.conf <<'EOF'

# Monitor hotplug handler
exec-once = ~/.config/hypr/monitor_reconnect.sh
exec-once = udevadm monitor --subsystem-match=drm --property | grep --line-buffered "HOTPLUG" | while read; do ~/.config/hypr/monitor_reconnect.sh; done
EOF

echo "Configuration complete - use 'source = ~/.config/hypr/monitors.conf' in your hyprland.conf"
