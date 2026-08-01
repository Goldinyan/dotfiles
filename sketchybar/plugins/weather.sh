
#!/bin/bash
DATA=$(curl -s "https://api.open-meteo.com/v1/forecast?latitude=51.73&longitude=6.59&current=temperature_2m,precipitation")
TEMP=$(echo $DATA | jq '.current.temperature_2m')
RAIN=$(echo $DATA | jq '.current.precipitation')

ICON="" # default: clear
[ "$RAIN" != "0" ] && ICON="" # rain icon

echo "icon=$ICON label=${TEMP}°C"
