#!/usr/bin/env bash

# Replace this with your vault path
VAULT_PATH="$HOME/engineering-daybook/"

# Get the first Obsidian window
WIN_INFO=$(swaymsg -t get_tree | jq -r '.. | select(.class?=="obsidian") | "\(.id) \(.workspace)"' | head -n1)

if [ -n "$WIN_INFO" ]; then
    # Split into ID and workspace
    WIN_ID=$(echo $WIN_INFO | awk '{print $1}')
    WIN_WS=$(echo $WIN_INFO | awk '{print $2}')

    # Switch to the window's workspace and focus it
    swaymsg workspace "$WIN_WS"
	swaymsg '[class="obsidian"] focus'
else
    # Launch Obsidian with the vault
    obsidian --vault "$VAULT_PATH" &
fi
