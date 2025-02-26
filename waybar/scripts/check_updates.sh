#!/bin/bash
# Count available updates using checkupdates (ensure you have the checkupdates script installed).
updates=$(checkupdates 2>/dev/null | wc -l)
if [ "$updates" -gt 0 ]; then
  echo "$updates updates"
else
  echo "Up to date"
fi
