#!/bin/bash

# Function to install zsh
install_zsh() {
  echo "Installing Zsh..."
  
  # Check for package manager and install Zsh
  if [ -x "$(command -v apt-get)" ]; then
    sudo apt-get update
    sudo apt-get install -y zsh
  elif [ -x "$(command -v yum)" ]; then
    sudo yum install -y zsh
  elif [ -x "$(command -v brew)" ]; then
    brew install zsh
  else
    echo "Error: Package manager not found. Please install Zsh manually."
    exit 1
  fi
  
  echo "Zsh installed successfully."
}

# Function to install Oh My Zsh
install_oh_my_zsh() {
  echo "Installing Oh My Zsh..."
  
  # Install Oh My Zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  
  echo "Oh My Zsh installed successfully."
}

# Function to install zsh plugins
install_zsh_plugins() {
  echo "Installing Zsh plugins..."

  # Define the custom plugin directory for Oh My Zsh
  ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}

  # Install zsh-syntax-highlighting plugin
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
  
  # Install zsh-autosuggestions plugin
  git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
  
  echo "Zsh plugins installed successfully."
}

# Function to install the agnoster theme
install_agnoster_theme() {
  echo "Installing Agnoster theme..."

  # Download and place the agnoster theme in the themes directory
  ZSH_THEMES_DIR=~/.oh-my-zsh/themes
  mkdir -p $ZSH_THEMES_DIR
  curl -fsSL https://github.com/pixegami/terminal-profile/blob/main/configs/pixegami-agnoster.zsh-theme -o $ZSH_THEMES_DIR/pixegami-agnoster.zsh-theme

  echo "Agnoster theme installed successfully."
}

# Execute the functions
install_zsh
install_oh_my_zsh
install_zsh_plugins
install_agnoster_theme
# Set Zsh as the default shell
chsh -s $(which zsh)

echo "Zsh, Oh My Zsh, and plugins are now installed. Zsh is set as the default shell."
