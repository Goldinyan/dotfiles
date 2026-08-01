#!/bin/bash

wifi=(
    icon=""
    icon.font="$FONT:Regular:14.0"
    label.font="$FONT:Regular:10.0"
    script="$PLUGIN_DIR/wifi.sh"
)

sketchybar --add item wifi right \
           --set wifi "${wifi[@]}" \
           --subscribe wifi wifi_change mouse.clicked
