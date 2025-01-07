#!/usr/bin/bash
# this should be used to install the necessary programs that I use

# The following will be installed
# 1. Neovim
# 2. Rust
# 3. Golang
# 4. Tmux and TPM
# 5. RipGrep
# 6. Nix
# 7. Zsh (this will be made the default as well)
# 8. GNU Stow
# 9. Node and NVM
# 10. Julia

# Install Tmux and TPM
install_tmux_and_tpm() {
    if ! command -v tmux &>/dev/null; then
        sudo apt update && sudo apt install -y tmux
    fi
    if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    else
        echo "TPM is already installed"
    fi
}

# Check and install function
check_install_old() {
    if command -v "$1" &>/dev/null; then
        echo "$1 is already installed"
    else
        echo "Installing $1..."
        $2
    fi
}

check_install() {
	if dpkg -l | grep -q "$1"; then 
		echo "$1 is already installed"
	else 
		echo "Installing $1"
		$2
	fi
}

# Neovim
install_neovim() {
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
    sudo rm -rf /opt/nvim
    sudo tar -C /opt -xzf nvim-linux64.tar.gz
    sudo ln -sf /opt/nvim/bin/nvim /usr/local/bin/nvim
    rm nvim-linux64.tar.gz
}

# Rust
install_rust() {
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
}

# Go
install_go() {
    curl -LO https://golang.org/dl/go1.23.4.linux-amd64.tar.gz
    sudo rm -rf /usr/local/go
    sudo tar -C /usr/local -xzf go1.23.4.linux-amd64.tar.gz
    # echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
    # source ~/.bashrc
    rm go1.23.4.linux-amd64.tar.gz
}

# Nix
install_nix() {
    curl -L https://nixos.org/nix/install | sh
    . "$HOME/.nix-profile/etc/profile.d/nix.sh"
}

# Zsh
install_zsh() {
    sudo apt update && sudo apt install -y zsh
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi
    chsh -s "$(which zsh)"
}

# Node and NVM
install_node() {
    sudo apt update && sudo apt install -y nodejs npm
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
}

# Julia
install_julia() {
    curl -fsSL https://install.julialang.org | sh
}

# Ripgrep
install_ripgrep() {
    sudo apt update && sudo apt install -y ripgrep
}

# GNU Stow
install_stow() {
    sudo apt update && sudo apt install -y stow
}

# Installation
sudo apt update
check_install nvim install_neovim
check_install cargo install_rust
check_install go install_go
check_install tmux install_tmux_and_tpm
check_install zsh install_zsh
check_install node install_node
check_install julia install_julia
check_install rg install_ripgrep
check_install stow install_stow
check_install nix install_nix

