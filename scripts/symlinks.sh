#!/bin/bash

# Set the base directory for your dotfiles
DOTFILES_DIR=$(pwd)

# Define an associative array for destination directories
declare -A DESTINATIONS=(
    ["sway"]="$HOME/.config/sway"
    ["waybar"]="$HOME/.config/waybar"
    ["ghostty"]="$HOME/.config/ghostty"
    ["nvim"]="$HOME/.config/nvim"
    ["zsh/themes"]="$HOME/.oh-my-zsh/custom/themes"
    ["tmux"]="$HOME/.tmux.conf"
    ["yazi"]="$HOME/.config/yazi"
)

# Symlink each package's configuration
for PACKAGE in "${!DESTINATIONS[@]}"; do
    SRC="$DOTFILES_DIR/packages/$PACKAGE"
    DEST="${DESTINATIONS[$PACKAGE]}"
    
    if [ -d "$SRC" ]; then
        echo "Creating symlink for $PACKAGE -> $DEST"
        mkdir -p "$DEST"
        ln -sfn "$SRC"/* "$DEST/"
    else
        echo "Warning: $SRC does not exist, skipping."
    fi
done

# Symlink top-level files or scripts if needed
echo "Symlinking top-level scripts to ~/bin (requires ~/bin to exist)"
mkdir -p "$HOME/bin"
for SCRIPT in "$DOTFILES_DIR/scripts"/*; do
    ln -sfn "$SCRIPT" "$HOME/bin/$(basename "$SCRIPT")"
done

echo "Symlinking complete!"

