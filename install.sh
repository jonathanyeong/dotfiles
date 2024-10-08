#!/bin/bash

# Sets zsh to be the default shell when connecting over ssh
sudo chsh "$(id -un)" --shell "/usr/bin/zsh"

# echo "[-] Download fonts [-]"
# echo "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FiraCode.zip"
# wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FiraCode.zip
# unzip FiraCode.zip -d ~/.fonts
# TODO: Make this check if fc-cache is installed
# also check if it's a mac or not.
# sudo apt install fontconfig
# fc-cache -fv
# echo "done!"

# Installs starship for zsh
export ZSH_CUSTOM="$HOME/.oh-my-zsh"
curl -sS https://starship.rs/install.sh | sh -s -- -f
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Sets Git config values
# echo "Setting up Git config."
# git config --global core.editor "code"

create_symlinks() {
    # Get the directory in which this script lives.
    script_dir=$(dirname "$(readlink -f "$0")")

    # Get a list of all files in this directory that start with a dot.
    files=$(find -maxdepth 1 -type f -name ".*")

    # Create a symbolic link to each file in the home directory.
    for file in $files; do
        name=$(basename $file)
        echo "Creating symlink to $name in home directory."
        rm -rf ~/$name
        ln -s $script_dir/$name ~/$name
    done
}

create_symlinks