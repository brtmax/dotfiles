#!/bin/bash

# Remote server
REMOTE_USER=max
REMOTE_HOST=cube.local
REMOTE_BASE=~/Backups/tower

# Local folders to sync
FOLDERS=("Documents" "engineering-daybook" "repos")

# Loop through each folder and sync
for folder in "${FOLDERS[@]}"; do
    rsync -av --delete ~/"$folder" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_BASE/$folder"
done
