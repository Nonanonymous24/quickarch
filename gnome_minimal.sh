#!/bin/bash

### SET YOUR VARIABLES HERE
COUNTRY=China ### For mirrorlist

### SCRIPT START

# Ctrl + c exits entire script
trap "exit" INT

# if error is reached, script exits
set -e

/bin/echo -e "\e[1;32mInstalling Gnome Desktop Environment...\e[0m"
# Sync mirrors using reflector
/bin/echo -e "\eSyncing pacman mirrors in $COUNTRY...\e[0m"
sudo pacman -Syy --needed --noconfirm reflector
sudo reflector -c $COUNTRY -a 6 --sort rate --save /etc/pacman.d/mirrorlist
## Might get some timeout errors here, but no need to worry about that.
/bin/echo -e "\e[1;32mMirrors synced.\e[0m"

# Set up an aur helper (yay)
/bin/echo -e "\e[1;32mInstalling yay...\e[0m"
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si -r --needed --noconfirm -p PKGBUILD
cd ~
/bin/echo -e "\e[1;32mInstalled yay.\e[0m"

# Install packages (display server, display manager, desktop environment, browser)
/bin/echo -e "\e[1;32mInstalling display server, display manager, DE and browser\e[0m"
sudo pacman -S --noconfirm xorg gdm neofetch gnome gnome-tweaks chrome-gnome-shell

# Enable GDM
/bin/echo -e "\e[1;32mEnabling GDM...\e[0m"
sudo systemctl enable gdm
/bin/echo -e "\e[1;32mEnabled GDM.\e[0m"

/bin/echo -e "\e[1;32mGnome is installed.\e[0m"
# Reboot system
/bin/echo -e "\e[1;32mSystem will reboot in 5 seconds.\e[0m"
sleep 5
sudo reboot

### SCRIPT END
