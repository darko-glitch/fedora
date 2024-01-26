#!/bin/bash

# Add Minimize and Maximize Window Buttons
gsettings set org.gnome.desktop.wm.preferences button-layout ':minimize,maximize,close'

# Night Light Settings
gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-from 12.0
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-to 11.9

# Modify dnf.conf
echo "max_parallel_downloads=10" | sudo tee -a /etc/dnf/dnf.conf
echo "fastestmirror=true" | sudo tee -a /etc/dnf/dnf.conf
echo "deltarpm=true" | sudo tee -a /etc/dnf/dnf.conf

# Update system
sudo dnf update -y

echo "Minimize and Maximize Window Buttons added and Night Light settings configured."

# Add Brave Browser repository
sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo

# Import Brave Browser GPG key
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc

# Install Brave Browser and brave-keyring
sudo dnf install -y brave-browser brave-keyring

echo "Brave Browser installation completed."

# Install RPM Fusion repositories
sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Set hostname
sudo hostnamectl set-hostname "dark"

# Install dnf-plugins-core
sudo dnf install -y dnf-plugins-core zsh zsh-autosuggestions @base-x gnome-extensions-app zsh zsh-autosuggestions gnome-browser-connector gnome-shell gnome-terminal dnf-plugins-core gnome-calculator gnome-system-monitor gedit file-roller nautilus gnome-tweaks @development-tools mpv git wget gnome-terminal-nautilus xdg-user-dirs xdg-user-dirs-gtk steam curl gcc g++ ufw make gdb gnome-tweaks gnome-extensions-app gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel lame\* --exclude=lame-devel

# Set default target to graphical
sudo systemctl set-default graphical.target

# Configure Firewall (UFW)
sudo ufw limit 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw enable

# Upgrade multimedia group
sudo dnf group upgrade -y --with-optional Multimedia

# Add user to groups
sudo usermod -aG render,video dark

cd ~/Downloads
git clone https://gitlab.com/kalilinux/packages/kali-themes.git
sudo mv -f kali-themes/share/themes/Kali* /usr/share/themes/
sudo mv -f kali-themes/share/icons/* /usr/share/icons/
sudo mv -f kali-themes/share/* /usr/share/
sudo mv -f kali-themes/share/backgrounds/* /usr/share/backgrounds
sudo mv -f kali-themes/share/gtksourceview-4/styles/* /usr/share/gtksourceview-4/styles
sudo chmod 755 $(sudo find /usr/share/themes/Kali* -type d)
sudo chmod 644 $(sudo find /usr/share/themes/Kali* -type f)
sudo chmod 755 $(sudo find /usr/share/icons/Flat* -type d)
sudo chmod 644 $(sudo find /usr/share/icons/Flat* -type f)
sudo gtk-update-icon-cache /usr/share/icons/Flat-Remix-Blue-Dark/

# Download and apply Zsh configuration
mv .zshrc ~/.zshrc
chsh -s /bin/zsh
autoload -Uz compinit promptinit

# Copy Kali Linux color scheme for qtermwidget
sudo cp ~/Downloads/kali-themes/share/qtermwidget5/color-schemes/Kali-Dark.colorscheme /usr/share/qtermwidget5/color-schemes/Kali-Dark.colorscheme

# Clean up by removing the cloned repository
rm -rf kali-themes

# Configure Firewall (UFW)
sudo ufw limit 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw enable

# Install Miniconda
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh
bash ~/miniconda.sh -b -p $HOME/miniconda
eval "$($HOME/miniconda/bin/conda shell.bash hook)"
conda init

# Update Conda and Create a Python Environment
conda update --all -y
conda create -y -n ai python spyder notebook
conda activate ai

# Install TensorFlow-ROCm
pip install tensorflow-rocm

# Update system
sudo dnf update -y