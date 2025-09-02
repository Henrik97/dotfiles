#!/bin/bash
# This is a simple example; adjust according to your Bluetooth manager.
status=$(bluetoothctl show | grep "Powered" | awk '{print $2}')
if [ "$status" = "yes" ]; then
  echo "BT On"
else
  echo "BT Off"
fi
