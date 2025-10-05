#!/usr/bin/env bash
count=$(makoctl list | jq 'length')

if [ "$count" -gt 0 ]; then
  echo "{\"text\":\"🔔 $count\"}"
else
  echo "{\"text\":\"🔕\"}"
fi
