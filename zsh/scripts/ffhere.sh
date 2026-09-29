#!/bin/zsh

# get terminal & space state
TERM_WIN=$(yabai -m query --windows --window | jq -r '.id')
CURRENT_SPACE=$(yabai -m query --spaces --space | jq -r '.index')
WIN_INFO=$(yabai -m query --windows --window)

IS_FLOATING=$(echo "$WIN_INFO" | jq -r '."is-floating"')
X=$(echo "$WIN_INFO" | jq -r '.frame.x')
Y=$(echo "$WIN_INFO" | jq -r '.frame.y')
W=$(echo "$WIN_INFO" | jq -r '.frame.w')
H=$(echo "$WIN_INFO" | jq -r '.frame.h')

# launch new browser
BROWSER="Firefox"
open -n -a "$BROWSER" --args -new-window

# wait for browser to become the FOCUSED window (max 3 seconds)
BROWSER_WIN=""
for i in {1..60}; do
  FOCUSED_APP=$(yabai -m query --windows --window 2>/dev/null | jq -r '.app')
  if [ "$FOCUSED_APP" = "$BROWSER" ]; then
    BROWSER_WIN=$(yabai -m query --windows --window 2>/dev/null | jq -r '.id')
    break
  fi
  sleep 0.05
done

if [ -n "$BROWSER_WIN" ]; then
  # Check for native fullscreen
  IS_FULLSCREEN=$(yabai -m query --windows --window "$BROWSER_WIN" | jq -r '."is-native-fullscreen"')
  
  if [ "$IS_FULLSCREEN" = "true" ]; then
    yabai -m window "$BROWSER_WIN" --toggle native-fullscreen
    sleep 1.0 # WE MUST WAIT for the macos animation to finish
  fi

  # move to terminal's space
  yabai -m window "$BROWSER_WIN" --space "$CURRENT_SPACE" 2>/dev/null
  yabai -m window --focus "$BROWSER_WIN" 2>/dev/null

  # sync float and size with kitty
  BROWSER_IS_FLOAT=$(yabai -m query --windows --window "$BROWSER_WIN" | jq -r '."is-floating"')
  
  if [ "$IS_FLOATING" = "true" ]; then
    if [ "$BROWSER_IS_FLOAT" = "false" ]; then
      yabai -m window "$BROWSER_WIN" --toggle float
    fi
    yabai -m window "$BROWSER_WIN" --move abs:$X:$Y
    yabai -m window "$BROWSER_WIN" --resize abs:$W:$H
  else
    if [ "$BROWSER_IS_FLOAT" = "true" ]; then
      yabai -m window "$BROWSER_WIN" --toggle float
    fi
  fi
fi

# close terminal
if [ -n "$TERM_WIN" ]; then
  yabai -m window "$TERM_WIN" --close 2>/dev/null
fi

kill -9 $PPID 2>/dev/null
