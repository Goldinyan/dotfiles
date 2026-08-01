#!/bin/bash

source "$CONFIG_DIR/colors.sh"

BATTERY_INFO="$(pmset -g batt)"
PERCENTAGE=$(echo "$BATTERY_INFO" | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(echo "$BATTERY_INFO" | grep 'AC Power')

if [[ $PERCENTAGE == "" ]]; then
    exit 0
fi

ICON_100=""
ICON_75=""
ICON_50=""
ICON_25=""
ICON_0=""
ICON_CHARGING=""

COLOR=$BLACK

case ${PERCENTAGE} in
    9[0-9]|100)
        ICON="$ICON_100"
        ;;
    [6-8][0-9])
        ICON="$ICON_75"
        ;;
    [3-5][0-9])
        ICON="$ICON_50"
        ;;
    [1-2][0-9])
        ICON="$ICON_25"
        COLOR=$ORANGE
        ;;
    *)
        ICON="$ICON_0"
        COLOR=$RED
        ;;
esac

if [[ $CHARGING != "" ]]; then
    ICON="$ICON_CHARGING"
fi

sketchybar --set "$NAME" icon="$ICON" icon.color="$COLOR" label="$PERCENTAGE%"
