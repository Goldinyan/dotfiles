#!/bin/bash

# Try to get CPU temperature from powermetrics
if command -v powermetrics &> /dev/null; then
    TEMP=$(powermetrics -n 1 2>/dev/null | grep "CPU die temperature" | head -1 | awk '{for(i=NF;i>=1;i--) if($i ~ /^[0-9]+\.?[0-9]*$/) {print int($i); break}}')
fi

# Fallback: try sysctl
if [ -z "$TEMP" ]; then
    TEMP=$(sysctl -n hw.sensors.cpu0.temp0_c 2>/dev/null || echo "")
    if [ ! -z "$TEMP" ]; then
        TEMP=$(printf "%.0f" "$TEMP" 2>/dev/null)
    fi
fi

# If still empty, set default
if [ -z "$TEMP" ] || [ "$TEMP" = "" ]; then
    TEMP="--"
fi

sketchybar --set "$NAME" label="${TEMP}°"
