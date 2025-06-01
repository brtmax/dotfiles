#!/bin/bash

WALLPAPER_DIR="$HOME/Documents/mojave_dynamic"

set_wallpaper() {
    local wallpaper_number=$1
    if [ -f /tmp/swaybg.pid ]; then
        kill $(cat /tmp/swaybg.pid) 2>/dev/null
        rm /tmp/swaybg.pid
    fi
    swaybg -i "$WALLPAPER_DIR/$wallpaper_number.jpeg" -m fill &
    echo $! > /tmp/swaybg.pid
}

get_wallpaper_number() {
    local current_hour=$(date +%H | sed 's/^0*//')
    local current_minute=$(date +%M | sed 's/^0*//')
    local total_minutes=$((current_hour * 60 + current_minute))
    local segment=$((total_minutes / 60))
    local wallpaper_number=$((segment))
    if [ $wallpaper_number -gt 24 ]; then
        wallpaper_number=1
    fi
    echo $wallpaper_number
}

cleanup() {
    if [ -f /tmp/swaybg.pid ]; then
        kill $(cat /tmp/swaybg.pid) 2>/dev/null
        rm /tmp/swaybg.pid
    fi
    exit 0
}

trap cleanup EXIT

set_wallpaper $(get_wallpaper_number)

while true; do
    current_hour=$(date +%H | sed 's/^0*//')
    current_minute=$(date +%M | sed 's/^0*//')
    total_minutes=$((current_hour * 60 + current_minute))
    minutes_until_next_segment=$((90 - (total_minutes % 90)))
    sleep $((minutes_until_next_segment * 60))
    set_wallpaper $(get_wallpaper_number)
done
