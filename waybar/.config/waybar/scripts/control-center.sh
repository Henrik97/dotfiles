#!/usr/bin/env bash

show_menu() {
  wifi=$(nmcli -t -f ACTIVE,SSID dev wifi | grep '^yes' | cut -d: -f2)
  [ -z "$wifi" ] && wifi="No Wi-Fi"

  bt_status=$(bluetoothctl show | grep "Powered: yes" >/dev/null && echo "On" || echo "Off")

  volume=$(pamixer --get-volume-human 2>/dev/null || echo "N/A")

  printf "󰤨 Network: %s\n󰂯 Bluetooth: %s\n󰕾 Volume: %s\n󰌌 System Monitor\n" "$wifi" "$bt_status" "$volume" |
    wofi --dmenu -p "Control Center"
}

action_menu() {
  choice=$(show_menu)

  case "$choice" in
  *Network*) kitty -e nmtui ;;
  *Bluetooth*) blueman-manager ;;
  *Volume*) pavucontrol ;;
  *System*) kitty -e btop ;;
  esac
}

# For Waybar live text (when used as module exec)
if [ "$1" != "open" ]; then
  wifi=$(nmcli -t -f ACTIVE,SSID dev wifi | grep '^yes' | cut -d: -f2)
  [ -z "$wifi" ] && wifi="Offline"

  volume=$(pamixer --get-volume-human 2>/dev/null || echo "?")

  echo "{\"text\":\"⚙️  $wifi | 🔊 $volume\"}"
else
  action_menu
fi
