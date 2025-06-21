#!/bin/bash


# Exit on error
set -e

# Check if zsh is installed
if ! command -v zsh &> /dev/null; then
    echo "Zsh is not installed. Please install zsh first."
    exit 1
fi

# Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "Oh My Zsh is already installed."
fi

# Install plugins
ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}

# Install zsh-autosuggestions
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    echo "Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
else
    echo "zsh-autosuggestions is already installed."
fi

# Install zsh-syntax-highlighting
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    echo "Installing zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
else
    echo "zsh-syntax-highlighting is already installed."
fi

# Install zsh-completions
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-completions" ]; then
    echo "Installing zsh-completions..."
    git clone https://github.com/zsh-users/zsh-completions "$ZSH_CUSTOM/plugins/zsh-completions"
else
    echo "zsh-completions is already installed."
fi

# Backup existing .zshrc if it exists
if [ -f "$HOME/.zshrc" ]; then
    echo "Backing up existing .zshrc to .zshrc.bak"
    cp "$HOME/.zshrc" "$HOME/.zshrc.bak"
fi

# Configure .zshrc
cat << EOF > "$HOME/.zshrc"
export ZSH="\$HOME/.oh-my-zsh"

ZSH_THEME="dst"

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-completions
)

source \$ZSH/oh-my-zsh.sh

# Enable completion
autoload -U compinit && compinit
EOF

echo "Installation complete! Please run 'source ~/.zshrc' or restart your terminal."
echo "If zsh is not your default shell, you can set it using: chsh -s \$(which zsh)"


