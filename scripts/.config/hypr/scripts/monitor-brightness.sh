#!/bin/bash
# monitor-brightness.sh
# Adjust brightness on all connected DDC/CI monitors, auto-detecting setup

STEP=10 # percentage step size

# Detect connected DDC-capable monitors
BUSES=$(ddcutil detect 2>/dev/null | grep -o '/dev/i2c-[0-9]*') || exit 0
[ -z "$BUSES" ] && exit 0

for BUS in $BUSES; do
  # Get current brightness (VCP code 10)
  current=$(ddcutil -b ${BUS#/dev/i2c-} getvcp 10 2>/dev/null | awk '{print $9}' | tr -d ',')
  [[ -z "$current" ]] && continue

  case "$1" in
  up)
    new=$((current + STEP))
    [[ $new -gt 100 ]] && new=100
    ;;
  down)
    new=$((current - STEP))
    [[ $new -lt 0 ]] && new=0
    ;;
  set)
    new=$2
    ;;
  *)
    echo "Usage: $0 {up|down|set <value>}"
    exit 1
    ;;
  esac

  echo "Setting $BUS to $new%"
  ddcutil -b ${BUS#/dev/i2c-} setvcp 10 $new 2>/dev/null &
done

# Optional: Mako visual notification (if installed)
notify-send "Brightness" "$(ddcutil -b ${BUS#/dev/i2c-} getvcp 10 | awk '{print $9}' | tr -d ',')%"
