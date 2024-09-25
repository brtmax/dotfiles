#!/bin/bash

# Get the current directory (root of dotfiles repo)
DOTFILES_DIR=$(pwd)

# i3
mkdir -p ~/.config/i3
ln -sf $DOTFILES_DIR/i3/config ~/.config/i3/config

# nvim
mkdir -p ~/.config/nvim
ln -sf $DOTFILES_DIR/nvim/init.lua ~/.config/nvim/init.lua
ln -sf $DOTFILES_DIR/nvim/lua ~/.config/nvim/lua

# Ranger
mkdir -p ~/.config/ranger
ln -sf $DOTFILES_DIR/ranger/rc.conf ~/.config/ranger/rc.conf
ln -sf $DOTFILES_DIR/ranger/rifle.conf ~/.config/ranger/rifle.conf
ln -sf $DOTFILES_DIR/ranger/commands.py ~/.config/ranger/commands.py
ln -sf $DOTFILES_DIR/ranger/scope.sh ~/.config/ranger/scope.sh

# Terminator
mkdir -p ~/.config/terminator
ln -sf $DOTFILES_DIR/terminator/config ~/.config/terminator/config

# tmux
ln -sf $DOTFILES_DIR/tmux/.tmux.conf ~/.tmux.conf

# zsh
ln -sf $DOTFILES_DIR/zsh/.zshrc ~/.zshrc

# Confirmation
echo "Dotfiles have been symlinked!"
