#!/bin/bash

# Copy spam.sh to /usr/local/bin
sudo cp spam.sh /usr/local/bin/spam

# Make spam.sh executable
sudo chmod +x /usr/local/bin/spam

# Add /usr/local/bin to PATH in .zshrc
echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.zshrc

# Source .zshrc to update PATH
source ~/.zshrc

echo "spam command installed successfully!"
sudo reboot
