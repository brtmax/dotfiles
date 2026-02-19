#!/bin/bash

TIMEWALL_BIN="$HOME/.cargo/bin/timewall"
WALLPAPER_DIR="$HOME/Documents/Wallpapers/dynamic-wallpapers"

mapfile -t files < <(find "$WALLPAPER_DIR" -type f -iname "*.heic")
if [ ${#files[@]} -eq 0 ]; then
    echo "No HEIC files found in $WALLPAPER_DIR"
    exit 1
fi

RANDOM_FILE="${files[RANDOM % ${#files[@]}]}"

export TIMEWALL_WALLPAPER="$RANDOM_FILE"

"$TIMEWALL_BIN" set "$RANDOM_FILE"
"$TIMEWALL_BIN" set --daemon
