#!/bin/bash

# Add RPM Fusion repositories
sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Install necessary packages and groups
sudo dnf install -y @base-x gnome-extensions-app zsh zsh-autosuggestions gnome-browser-connector gnome-shell gnome-terminal dnf-plugins-core gnome-calculator gnome-system-monitor gedit file-roller nautilus gnome-tweaks @development-tools

# Install additional packages and groups
sudo dnf group install -y "Hardware Support"
sudo dnf install -y gnome-terminal-nautilus xdg-user-dirs xdg-user-dirs-gtk

# Set default target to graphical
sudo systemctl set-default graphical.target

# Change default shell to Zsh
chsh -s /bin/zsh

# All done
echo "Installation completed."
