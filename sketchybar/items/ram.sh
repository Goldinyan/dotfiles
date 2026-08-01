#!/bin/bash

#!/bin/bash

ram=(
    icon.drawing=off
    label.font="$FONT:Regular:12.0"
    update_freq=4
    label.padding_right=8
    script="$PLUGIN_DIR/ram.sh"
)

sketchybar --add item ram right \
           --set ram "${ram[@]}"
