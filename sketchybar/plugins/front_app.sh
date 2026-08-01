#!/bin/bash

if [ "$SENDER" = "front_app_switched" ]; then
    LABEL="$INFO"
    
    # Wenn Kitty im Fokus ist, zeige den aktuellen Pfad
    if [ "$INFO" = "kitty" ]; then
        CURRENT_WINDOW=$(yabai -m query --windows --window | jq '.id')
        PID=$(yabai -m query --windows --window | jq '.pid')
        if [ ! -z "$PID" ]; then
            CURRENT_DIR=$(lsof -p "$PID" 2>/dev/null | grep cwd | awk '{print $NF}' | head -1)
            if [ ! -z "$CURRENT_DIR" ]; then
                LABEL=$(basename "$CURRENT_DIR")
            fi
        fi
    fi
    
    sketchybar --set "$NAME" label="$LABEL" icon.background.image="app.$INFO" icon.background.image.scale=0.6
fi
