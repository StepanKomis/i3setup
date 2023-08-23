#!/bin/bash
set -e
pacman -Syu
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si


# Check if the script is being run as root
if [ "$EUID" -ne 0 ]; then
    echo "This script must be run as root."
    exit 1
fi

# Install official packages from the list
while read -r package; do
    pacman -S --noconfirm "$package"
done < installed_official_packages.txt

# Install AUR packages from the list using yay
while read -r package; do
    yay -S --noconfirm "$package"
done < installed_aur_packages.txt

cp ./configs/* ~/.config/
cp ./usr/bin/neofetch /usr/bin/neofetch
echo "All packages installed successfully."
