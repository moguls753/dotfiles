#!/bin/bash

# kill any running instances if they exist
~/dev/eww/target/release/eww daemon

# start a bar for each monitor
monitors=$(hyprctl monitors -j | jq '.[] | .id')
# monitors=$(hyprctl monitors -j | jq '.[] | .id' | wc -l)

for monitor in ${monitors}; do
    ~/dev/eww/target/release/eww open bar${monitor}
done

# eww open bar0
# if [ $monitors -gt 1 ]; then
# 	for ((i = 1 ; i <= $monitors ; i++)); do
# 		eww open bar${i}
# 	done
# fi
