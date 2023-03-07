#/bin/bash


# Install NVM
brew install nvm


#  ~/.bash_profile or ~/.zshrc 
cat << EOF >> ~/.zshrc
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
EOF

source $(brew --prefix nvm)/nvm.sh
source ~/.bash_profile
source ~/.zshrc
