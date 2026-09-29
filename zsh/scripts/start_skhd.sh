#!/usr/bin/env bash
TARGET_LINK="$HOME/.config/skhd"
CORRECT_SOURCE="/Users/ansgarseifert/.config/skhd"

skhd --start-service

# if wrong path
if ps aux | grep "[s]khd" | grep -q "/Users/ansgar/"; then
	echo "Wrong skhd path detected. Cleaning up..."

  pkill -9 -f skhd

  rm -f /tmp/skhd*.pid /tmp/skhd*.socket

  ln -sfn "$CORRECT_SOURCE" "$TARGET_LINK"

  skhd --restart-service
  echo "skhd was restarted with the correct path."
  sleep 1
  clear
else
fi
