#!/usr/bin/env bash
set -e

DOTFILES_DIR="$HOME/repos/dotfiles/packages"
CONFIG_DIR="$HOME/.config"

echo "🔗 Symlinking dotfiles and app configs..."

# 1. Handle application directories (go into ~/.config/)
for dir in "$DOTFILES_DIR"/*/; do
    name=$(basename "$dir")
    target="$CONFIG_DIR/$name"
    source="$dir"

    # Skip install scripts or README
    [[ "$name" == "install-packages.sh" || "$name" == "packages.txt" || "$name" == "README.md" ]] && continue

    # Backup existing target if it's not a symlink
    if [[ -e "$target" && ! -L "$target" ]]; then
        echo "Backing up existing $target → $target.bak"
        mv "$target" "$target.bak"
    fi

    # Create symlink
    echo "→ Linking $name → $target"
    ln -sfn "$source" "$target"
done

# 2. Handle single-file configs
declare -A FILE_LINKS=(
  ["$DOTFILES_DIR/tmux/.conf"]="$HOME/.tmux.conf"
  ["$DOTFILES_DIR/zsh/.zshrc"]="$HOME/.zshrc"
)

for src in "${!FILE_LINKS[@]}"; do
    dest="${FILE_LINKS[$src]}"
    if [[ -f "$src" ]]; then
        # Backup existing file if present
        if [[ -e "$dest" && ! -L "$dest" ]]; then
            echo "Backing up existing $dest → $dest.bak"
            mv "$dest" "$dest.bak"
        fi
        echo "→ Linking $(basename "$dest") → $dest"
        ln -sfn "$src" "$dest"
    fi
done

echo "All symlinks created!"

