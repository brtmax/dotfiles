#!/bin/bash

WALLPAPER_DIR="/home/max/Documents/mojave_dynamic"

set_wallpaper() {
    local wallpaper_number=$1
    local image="$WALLPAPER_DIR/$wallpaper_number.jpeg"

    # Ensure file exists before setting
    if [ -f "$image" ]; then
        swaymsg output "*" bg "$image" fill >/dev/null
    else
        echo "Missing wallpaper: $image" >> /tmp/dynamic-wallpaper.log
    fi
}

get_wallpaper_number() {
    local hour=$(date +%H)
    local wallpaper_number=$((10#$hour + 1))
    echo "$wallpaper_number"
}

# Initial set
set_wallpaper "$(get_wallpaper_number)"

# Loop forever
while true; do
    total_minutes=$((10#$(date +%H) * 60 + 10#$(date +%M)))
    minutes_until_next=$((90 - (total_minutes % 90)))
    sleep $((minutes_until_next * 60))
    set_wallpaper "$(get_wallpaper_number)"
done

