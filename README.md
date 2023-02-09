# 13XLabs - Tutorial Setup Guide 

Welcome to the Ubuntu Server Setup Guide for Newbies! 

Welcome to the tutorial for setting up a new server! This guide will help you get started with setting up your server quickly and easily. We will cover the basics of installation, configuration, and maintenance of your server. We will also discuss some of the more advanced features and how to use them. 

First, we will update the system with the command:
``` bash
sudo apt update
```

Next, we will install NVM with the command 
``` bash
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
```

After that, we will install Node.js with the command 
``` bash
nvm install 16 
nvm use 16
```

Then, we will install PM2 globally with the command
``` bash
npm i pm2 -g
```

Next, we will install NGINX with the commands
```
sudo apt install nginx -y
sudo systemctl enable nginx
sudo systemctl start nginx
```

Update ...