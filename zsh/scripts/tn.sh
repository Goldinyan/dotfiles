#!/usr/bin/env zsh

THEME_DIR="$HOME/.config/kitty/themes"
STATE_FILE="$HOME/.cache/kitty_theme_idx"

# if no dir
mkdir -p "$THEME_DIR"
mkdir -p "$(dirname "$STATE_FILE")"

# all conf file read
# n -> no errors
themes=("$THEME_DIR"/*.conf(N))

if [[ ${#themes} -eq 0 ]]; then
    echo "Found no .conf files in $THEME_DIR!"
    exit 1
fi

# curr idx
idx=0
if [[ -f "$STATE_FILE" ]]; then
    idx=$(cat "$STATE_FILE")
fi

next_idx=$(( (idx % ${#themes}) + 1 ))

# save curr idx
echo "$next_idx" > "$STATE_FILE"

kitty @ set-colors -a "${themes[$next_idx]}"
