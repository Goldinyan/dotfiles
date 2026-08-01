#!/bin/bash

update() {
    IP="$(ipconfig getifaddr en0)"

    ICON_CONNECTED=""
    ICON_DISCONNECTED=""
    ICON_HOTSPOT=""

    if [[ -n "$IP" ]]; then
        HOTSPOT=$(ipconfig getsummary en0 | grep sname | awk '{print $3}')
        if [[ $HOTSPOT != "" ]]; then
            ICON="$ICON_HOTSPOT"
        else
            ICON="$ICON_CONNECTED"
        fi
    else
        ICON="$ICON_DISCONNECTED"
    fi

    sketchybar --set "$NAME" icon="$ICON"
}

mouse_clicked() {
    IP="$(ipconfig getifaddr en0)"
    if [[ -z "$IP" ]]; then
        return
    fi

    SSID="$(sudo "$HOME"/.config/bin/ssid)"

    popup_properties=(
        popup.height=20
        popup.align=center
        popup.background.border_width=1
        popup.background.corner_radius=10
        popup.background.shadow.drawing=off
    )

    sketchybar --set "$NAME" "${popup_properties[@]}"

    sketchybar --add item wifi.ssid popup.wifi
    sketchybar --set wifi.ssid label="SSID: $SSID"

    sketchybar --add item wifi.ip popup.wifi
    sketchybar --set wifi.ip label="IP: $IP"

    sketchybar --set "$NAME" popup.drawing=toggle
}

case "$SENDER" in
    "mouse.clicked") mouse_clicked ;;
    "wifi_change") update ;;
esac
