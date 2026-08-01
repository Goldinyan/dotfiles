#!/bin/bash

update() {
    source "$CONFIG_DIR/colors.sh"

    COLOR="#949191"
    if [ "$SELECTED" = "true" ]; then
        COLOR="#FFFFFF"
    fi

    sketchybar --set "$NAME" \
        icon.highlight="$COLOR" \
        label.highlight="$COLOR" \
        background.drawing=on \
        background.border_width=2 \
        #background.border_color="$COLOR"
}

update

