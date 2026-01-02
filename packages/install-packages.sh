#!/usr/bin/env bash

# Exit immediately if a command fails
set -e

PKGFILE="packages.txt"

# Check if packages.txt exists
if [[ ! -f "$PKGFILE" ]]; then
  echo "Error: $PKGFILE not found."
  exit 1
fi

# Remove duplicates, empty lines, and comments
mapfile -t PACKAGES < <(grep -vE '^\s*(#|$)' "$PKGFILE" | sort -u)

# Check which AUR helper to use
if command -v yay &>/dev/null; then
  INSTALLER="yay"
elif command -v paru &>/dev/null; then
  INSTALLER="paru"
else
  INSTALLER="sudo pacman"
fi

echo "Using installer: $INSTALLER"
echo "Installing ${#PACKAGES[@]} packages..."

# Install each package if not already installed
for pkg in "${PACKAGES[@]}"; do
  if pacman -Qi "$pkg" &>/dev/null; then
    echo "$pkg is already installed."
  else
    echo "⬇️ Installing $pkg..."
    $INSTALLER -S --needed --noconfirm "$pkg"
  fi
done

echo "All packages processed successfully."

