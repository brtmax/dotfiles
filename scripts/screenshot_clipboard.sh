#!/bin/bash

# Take a screenshot of the selected area
grim -g "$(slurp)" /tmp/screenshot.png

# Edit the screenshot with swappy
# swappy -f /tmp/screenshot.png -o /tmp/screenshot_edited.png

# Copy the final screenshot to the clipboard
wl-copy < /tmp/screenshot.png

# Clean up temporary files
rm -f /tmp/screenshot.png # /tmp/screenshot_edited.png
