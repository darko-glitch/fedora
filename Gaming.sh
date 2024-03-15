#!/bin/bash

# Update package lists (recommended before installing)
sudo dnf update

# Enable the capucho/steamtinkerlaunch repository (unofficial)
sudo dnf copr enable capucho/steamtinkerlaunch

# Install required packages
sudo dnf install -y steamtinkerlaunch wine lutris steam gamemode

# Inform the user about the script's completion
echo "Steam Tinker Launch, Wine, Lutris, Steam, and Game Mode installed successfully."

# Optional: Add Steam Tinker Launch to Steam compatibility options
# (Uncomment the following line if desired)
steamtinkerlaunch compact add

exit 0

