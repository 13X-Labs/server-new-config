#/bin/bash

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add Homebrew to Terminal MacOS
cat << EOF >> ~/.bash_profile
# Add Homebrew to Terminal MacOS
eval "$(/opt/homebrew/bin/brew shellenv)"
EOF

cat << EOF >> ~/.zprofile
# Add Homebrew to Terminal MacOS
eval "$(/opt/homebrew/bin/brew shellenv)"
EOF

source ~/.bash_profile
source /.zprofile