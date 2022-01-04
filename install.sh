#!/bin/bash
# Originally from https://github.com/harry-cpp/code-nautilus/blob/master/install.sh

# Install python-nautilus
echo "Installing python-nautilus..."
if type "pacman" >/dev/null 2>&1; then
  pacman -Qs python-nautilus &>/dev/null
  if [ $? -eq 1 ]; then
    sudo pacman -S --noconfirm --needed python-nautilus
  fi
elif type "apt-get" >/dev/null 2>&1; then
  installed=$(apt list --installed python3-nautilus -qq 2>/dev/null)
  echo $installed
  if [ -z "$installed" ]; then
    sudo apt-get install -y python3-nautilus
  else
    echo "python3-nautilus is already installed."
  fi
elif type "dnf" >/dev/null 2>&1; then
  installed=$(dnf list --installed nautilus-python 2>/dev/null)
  if [ -z "$installed" ]; then
    sudo dnf install -y nautilus-python
  else
    echo "nautilus-python is already installed."
  fi
else
  echo "Failed to find python-nautilus, please install it manually."
fi

# Install gvfs
echo "Installing gvfs..."
if type "pacman" >/dev/null 2>&1; then
  pacman -Qs gvfs &>/dev/null
  if [ $? -eq 1 ]; then
    sudo pacman -S --noconfirm --needed gvfs
  fi
elif type "apt-get" >/dev/null 2>&1; then
  installed=$(apt list --installed gvfs-backends -qq 2>/dev/null)
  echo $installed
  if [ -z "$installed" ]; then
    sudo apt-get install -y gvfs-backends
  else
    echo "gvfs-archive is already installed."
  fi
elif type "dnf" >/dev/null 2>&1; then
  installed=$(dnf list --installed gvfs-archive 2>/dev/null)
  if [ -z "$installed" ]; then
    sudo dnf install -y gvfs-archive
  else
    echo "gvfs-archive is already installed."
  fi
else
  echo "Failed to find gvfs-archive, please install it manually."
fi

# Remove previous version and setup folder
echo "Removing previous version (if found)..."
mkdir -p ~/.local/share/nautilus-python/extensions
rm -f ~/.local/share/nautilus-python/extensions/archive-mount.py

# Download and install the extension
echo "Downloading newest version..."
wget --show-progress -q -O ~/.local/share/nautilus-python/extensions/archive-mount.py https://raw.githubusercontent.com/Lucas-Steinmann/archive-mount-nautilus/master/archive-mount.py

# Restart nautilus
echo "Restarting nautilus..."
nautilus -q

echo "Installation complete"
