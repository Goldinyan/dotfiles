#!/bin/zsh

APP="$1"
if [ -z "$APP" ]; then
  echo "Usage: $0 <AppName>"
  exit 1
fi

# 1. Info des aktuellen Terminals holen
WIN_INFO=$(yabai -m query --windows --window 2>/dev/null)

if [ -z "$WIN_INFO" ] || [ "$WIN_INFO" = "null" ]; then
  echo "[ERROR] COULD NOT GET CURRENT TERMINAL WINDOW INFO"
  exit 1
fi

TERM_WIN=$(echo "$WIN_INFO" | jq -r '.id')
CURRENT_SPACE=$(yabai -m query --spaces --space | jq -r '.index')

IS_FLOATING=$(echo "$WIN_INFO" | jq -r '."is-floating"')
X=$(echo "$WIN_INFO" | jq -r '.frame.x | floor')
Y=$(echo "$WIN_INFO" | jq -r '.frame.y | floor')
W=$(echo "$WIN_INFO" | jq -r '.frame.w | floor')
H=$(echo "$WIN_INFO" | jq -r '.frame.h | floor')

# 2. VOR dem Start: Alle aktuell existierenden Fenster-IDs der App speichern
OLD_WIN_IDS=$(yabai -m query --windows | jq -r \
  "map(select((.app | ascii_downcase) == \"${APP:l}\")) | .[].id" | tr '\n' ' ')

# 3. App neu starten
if ! open -n -a "$APP"; then
  echo "[ERROR] COULD NOT LAUNCH $APP"
  exit 1
fi

NEW_WIN_ID=""

# 4. Warten auf eine ID, die vorher noch NICHT existierte
for i in {1..40}; do
  # Alle aktuellen IDs der App abfragen
  CURRENT_APP_WINS=$(yabai -m query --windows | jq -r \
    "map(select((.app | ascii_downcase) == \"${APP:l}\" and .\"is-minimized\" == false)) | .[].id")
  
  for win_id in $=CURRENT_APP_WINS; do
    # Prüfen, ob diese win_id VORHER schon da war
    if [[ " $OLD_WIN_IDS " != *" $win_id "* ]]; then
      NEW_WIN_ID="$win_id"
      break 2
    fi
  done
  sleep 0.1
done

# 5. Positionierung & Tiling-Knoten übernehmen
if [ -n "$NEW_WIN_ID" ] && [ "$NEW_WIN_ID" != "null" ]; then
  # Auf den aktuellen Space holen
  yabai -m window "$NEW_WIN_ID" --space "$CURRENT_SPACE" 2>/dev/null
  
  if [ "$IS_FLOATING" = "true" ]; then
    # Terminal schwebte -> Neues Fenster floating machen & exakt auf Pos/Größe setzen
    yabai -m window "$NEW_WIN_ID" --toggle float 2>/dev/null
    yabai -m window "$NEW_WIN_ID" --move abs:$X:$Y 2>/dev/null
    yabai -m window "$NEW_WIN_ID" --resize abs:$W:$H 2>/dev/null
  else
    # Terminal war gekachelt -> Platz im Yabai Tree direkt mit dem Terminal TAUSCHEN
    # Falls das neue Fenster standardmäßig als float öffnet, erst un-floaten
    APP_IS_FLOAT=$(yabai -m query --windows --window "$NEW_WIN_ID" | jq -r '."is-floating"')
    [ "$APP_IS_FLOAT" = "true" ] && yabai -m window "$NEW_WIN_ID" --toggle float 2>/dev/null
    
    # Durch --swap übernimmt das neue Fenster exakt die Position des Terminals im Layout
    yabai -m window "$NEW_WIN_ID" --swap "$TERM_WIN" 2>/dev/null
  fi

  # Fokus auf das neue Fenster legen
  yabai -m window --focus "$NEW_WIN_ID" 2>/dev/null
fi

# Terminal beenden
kill -9 $PPID 2>/dev/null
