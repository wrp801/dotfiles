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


install_tmux_and_tpm() {
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}


check_install() {
    if command -v $1 &> /dev/null; then
        echo "$1 is already installed"
    else
        echo "Installing $1..."
        $2
    fi  
}


# neovim
install_neovim() {
    curl "-LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz"
    sudo rm -rf /opt/nvim
    sudo tar -C /opt -xzf nvim-linux64.tar.gz

    # if command -v nvim >/dev/null 2>&1; then
    #     echo "Neovim is already installed"
    # else
    #     curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
    #     sudo rm -rf /opt/nvim
    #     sudo tar -C /opt -xzf nvim-linux64.tar.gz
    # fi
}

# rust
install_rust() {
    "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"
    source ~/.cargo/env/bin
    # if command -v cargo >/dev/null 2>&1; then 
    #     echo "Rust is already installed"
    # else
    #     curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    #     source ~/.cargo/env/bin
    # fi
}


# go
install_go() {
    if command -v go >/dev/null 2>&1; then 
        echo "Go is already installed"
    else
         rm -rf /usr/local/go && tar -C /usr/local -xzf go1.23.4.linux-amd64.tar.gz
         # echo "export PATH=$PATH:/usr/local/go/bin" >> ./zsh/.zshrc
    fi
}

# nix 
install_nix() {
    sudo install -d -m755 -o $(id -u) -g $(id -g) /nix
    curl -L https://nixos.org/nix/install | sh
    source $HOME/.nix-profile/etc/profile.d/nix.sh
}

# zsh 
install_zsh() {
    sudo apt-get install zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" # download ohmyzsh
    chsh -s $(which zsh) # make zsh the default
}

# node and nvm 
install_node() {
    sudo apt install nodejs
    sudo apt install npm
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
}

# julia
install_julia() {
    curl -fsSL https://install.julialang.org | sh
}

# ripgrep 
install_ripgrep() {
    sudo apt-get install ripgrep
}

# gnu stow 
install_stow() {
    apt install -y stow
}

## Installation 

check_install nvim install_neovim
check_install cargo install_rust
check_install go install_go
check_install tmux install_tmux_and_tpm
check_install zsh install_zsh
check_install node install_node
check_install julia install_julia
check_install ripgrep install_ripgrep
check_install nix install_nix
check_install stow install_stow

