#!/bin/bash

FREE=$(memory_pressure | awk '/System-wide memory free percentage:/ {gsub("%","",$5); print $5}')
USED=$((100 - FREE))

sketchybar --set "$NAME" label="${USED}%"
