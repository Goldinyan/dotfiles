#!/bin/bash

WALLPAPER_DIR="$HOME/Desktop/media/bg"
STATE_FILE="$HOME/.local/state/current_wallpaper_index"

mkdir -p "$(dirname "$STATE_FILE")"

if [ ! -d "$WALLPAPER_DIR" ]; then
    echo "Error: Directory $WALLPAPER_DIR does not exist." >&2
    exit 1
fi

wallpapers=()
while IFS= read -r file; do
    wallpapers+=("$file")
done < <(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | sort)

count=${#wallpapers[@]}
if [ "$count" -eq 0 ]; then
    echo "Error: No images found in $WALLPAPER_DIR." >&2
    exit 1
fi

if [ -f "$STATE_FILE" ]; then
    current_index=$(<"$STATE_FILE")
    if ! [[ "$current_index" =~ ^[0-9]+$ ]]; then
        current_index=0
    fi
else
    current_index=0
fi

next_index=$(( (current_index + 1) % count ))
selected="${wallpapers[$next_index]}"

osascript -e "tell application \"System Events\" to tell every desktop to set picture to POSIX file \"$selected\"" >/dev/null 2>&1

spinstr='|/-\'
end_time=$((SECONDS + 5))

while [ $SECONDS -lt $end_time ]; do
    temp=${spinstr#?}
    printf " [%c]" "$spinstr"
    spinstr=$temp${spinstr%"$temp"}
    sleep 0.1
    printf "\r\033[K"
done

echo "$next_index" > "$STATE_FILE"
echo "Wallpaper updated successfully."
