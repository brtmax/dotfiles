#!/bin/bash

# Ensure script stops on error
set -e

# Set Zsh as the default shell if it is not already
echo "Setting Zsh as the default shell..."
if [[ "$SHELL" != "$(which zsh)" ]]; then
    chsh -s "$(which zsh)"
    echo "Default shell changed to Zsh."
else
    echo "Zsh is already the default shell."
fi

# Define .zshrc path
ZSHRC="$HOME/.zshrc"

# Backup existing .zshrc if it exists
if [[ -f "$ZSHRC" ]]; then
    echo "Backing up existing .zshrc to .zshrc.bak..."
    cp "$ZSHRC" "$ZSHRC.bak"
fi

# Ensure Oh My Zsh is installed
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    echo "Oh My Zsh not found. Installing..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "Oh My Zsh is already installed."
fi

# Add theme and plugin settings to .zshrc if not already present
echo "Configuring plugins and theme in .zshrc..."

# Append theme configuration if it doesn't exist
if ! grep -q 'ZSH_THEME' "$ZSHRC"; then
    echo 'ZSH_THEME="$HOME/dotfiles/zsh/themes/pixegami-agnoster.zsh-theme"' >> "$ZSHRC"
    echo "Theme set to pixegami-agnoster."
else
    echo "Theme is already set in .zshrc."
fi

# Append plugins configuration if not already present
if ! grep -q 'plugins=(' "$ZSHRC"; then
    echo 'plugins=(git zsh-autosuggestions zsh-syntax-highlighting)' >> "$ZSHRC"
    echo "Plugins configured."
else
    echo "Plugins are already configured in .zshrc."
fi

# Install Oh My Zsh plugins if they are not already installed
CUSTOM_PLUGINS="$HOME/.oh-my-zsh/custom/plugins"
echo "Ensuring plugins are installed..."

# Install zsh-autosuggestions if not already installed
if [[ ! -d "$CUSTOM_PLUGINS/zsh-autosuggestions" ]]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$CUSTOM_PLUGINS/zsh-autosuggestions"
fi

# Install zsh-syntax-highlighting if not already installed
if [[ ! -d "$CUSTOM_PLUGINS/zsh-syntax-highlighting" ]]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$CUSTOM_PLUGINS/zsh-syntax-highlighting"
fi

# Reload Zsh configuration to apply changes
echo "Reloading Zsh configuration..."
source "$ZSHRC"

echo "Zsh and Oh My Zsh are set up! Restart your terminal to apply changes."

