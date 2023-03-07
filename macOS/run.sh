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


# Add code . to Terminal MacOS
cat << EOF >> ~/.bash_profile
# Add Visual Studio Code (code)
export PATH="\$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
EOF

cat << EOF >> ~/.zprofile
# Add Visual Studio Code (code)
export PATH="\$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
EOF