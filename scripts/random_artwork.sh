#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/Documents/Wallpapers"

# Choose a random image
IMAGE=$(find "$WALLPAPER_DIR" -type f \( -iname '*.jpg' -o -iname '*.png' \) | shuf -n1)

swaymsg output DP-2 bg "$IMAGE" fill

