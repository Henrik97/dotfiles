#!/bin/bash
MONITORS=$(hyprctl monitors | grep "Monitor" | awk '{print $2}')

if echo "$MONITORS" | grep -q "eDP-1"; then
	echo "Setting up office monitors"
	hyprctl keyword monitor "eDP-1, 1920x1200@60,0x0,1"
	hyprctl keyword monitor "DP-2, 3840x2160@60,1920x0,1"
	hyprctl keyword monitor "DP-1, 2560x1400@60,5760x0,1"

	sleep 1

	hyprctl keyword workspace "1, monitor:DP-2"
	hyprctl keyword workspace "3, monitor:DP-2"
	hyprctl keyword workspace "5, monitor:DP-2"

	hyprctl keyword workspace "2, monitor:DP-1"
	hyprctl keyword workspace "4, monitor:DP-1"
	hyprctl keyword workspace "6, monitor:DP-1"


	hyprctl keyword workspace "7, monitor:eDP-1"




else
	echo "Setting up home monitors"
	
	hyprctl keyword monitor "DP-2, 2560x1400@60, 0x0, 1.0"
	hyprctl keyword monitor "HDMI-A-1, 1920x1080@60, 2560x0, 1.0"
	
	
	hyprctl keyword workspace "1, monitor:DP-2"
	hyprctl keyword workspace "3, monitor:DP-2"
	hyprctl keyword workspace "5, monitor:DP-2"
	
	hyprctl keyword workspace "2, monitor:HDMI-A-1"
	hyprctl keyword workspace "4, monitor:HDMI-A-1"
	hyprctl keyword workspace "6, monitor:HDMI-A-1"
		
fi

