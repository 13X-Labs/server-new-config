#/bin/bash

# Tutorial new server setup

# Update the system
sudo apt update

# Install NVM
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# restart the terminal
source .bashrc

# Install Node.js
nvm install 16
nvm use 16

# Install PM2 Globally
npm I pm2 -g


# Install NGINX
sudo apt install nginx -y
sudo systemctl enable nginx
sudo systemctl start nginx
