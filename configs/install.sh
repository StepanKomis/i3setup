#!/bin/bash
set -e

# Check if the script is being run as root
if [ "$EUID" -ne 0 ]; then
    echo "This script must be run as root."
    exit 1
fi

# Install packages from the list
while read -r package; do
    pacman -S --noconfirm "$package"
done < installed_packages.txt

cp ./configs/* ~/.config/
cp ./usr/bin/neofetch
echo "All packages installed successfully."