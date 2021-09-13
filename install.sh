#!/bin/bash
# Originally from https://github.com/harry-cpp/code-nautilus/blob/master/install.sh

# Install python-nautilus
echo "Installing python-nautilus..."
if type "pacman" >/dev/null 2>&1; then
  pacman -Qs python-nautilus gvfs &>/dev/null
  if [ $? -eq 1 ]; then
    sudo pacman -S --noconfirm --needed python-nautilus gvfs
  fi
elif type "apt-get" >/dev/null 2>&1; then
  installed=$(apt list --installed python-nautilus gvfs-backends -qq 2>/dev/null)
  if [ -z "$installed" ]; then
    sudo apt-get install -y python-nautilus gvfs-backends
  else
    echo "python-nautilus and gvfs-archive is already installed."
  fi
elif type "dnf" >/dev/null 2>&1; then
  installed=$(dnf list --installed nautilus-python gvfs-archive 2>/dev/null)
  if [ -z "$installed" ]; then
    sudo dnf install -y nautilus-python gvfs-archive
  else
    echo "nautilus-python and gvfs-archive is already installed."
  fi
else
  echo "Failed to find python-nautilus and/or gvfs-archive, please install it manually."
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
