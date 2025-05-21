#!/bin/bash

# Directory containing the wallpapers
WALLPAPER_DIR="$HOME/Documents/mojave_dynamic"

# Calculate which wallpaper to show (1-16)
# Each wallpaper is shown for 90 minutes (1.5 hours)
# Total cycle is 24 hours
current_hour=$(date +%H)
current_minute=$(date +%M)
total_minutes=$((current_hour * 60 + current_minute))
wallpaper_number=$(( (total_minutes / 90) % 16 + 1 ))

# Set the wallpaper using swaybg
swaybg -i "$WALLPAPER_DIR/mojave_dynamic_$wallpaper_number.jpeg" -m fill &

# Store the PID of swaybg
echo $! > /tmp/swaybg.pid

# Function to cleanup on exit
cleanup() {
    if [ -f /tmp/swaybg.pid ]; then
        kill $(cat /tmp/swaybg.pid) 2>/dev/null
        rm /tmp/swaybg.pid
    fi
    exit 0
}

# Set up trap for cleanup
trap cleanup EXIT

# Main loop to update wallpaper every 90 minutes
while true; do
    # Sleep until the next 90-minute mark
    current_minutes=$(( $(date +%H) * 60 + $(date +%M) ))
    minutes_to_sleep=$(( 90 - (current_minutes % 90) ))
    sleep $((minutes_to_sleep * 60))
    
    # Update wallpaper
    current_hour=$(date +%H)
    current_minute=$(date +%M)
    total_minutes=$((current_hour * 60 + current_minute))
    wallpaper_number=$(( (total_minutes / 90) % 16 + 1 ))
    
    # Kill existing swaybg
    if [ -f /tmp/swaybg.pid ]; then
        kill $(cat /tmp/swaybg.pid) 2>/dev/null
    fi
    
    # Start new swaybg
    swaybg -i "$WALLPAPER_DIR/mojave_dynamic_$wallpaper_number.jpeg" -m fill &
    echo $! > /tmp/swaybg.pid
done
