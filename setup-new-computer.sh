#!/bin/bash

COLUMNS=$(tput cols)

printHeading() {
    printf "\e[0;36m$1\e[0m \n"
}

printCompletedStep() {
    printf "\e[0;32m✔ $1 installed.\e[0m \n"
}

printDivider() {
    printf %"$COLUMNS"s |tr " " "-"
    printf "\n"
}

printError() {
    printf "\n\e[1;31m"
    printf %"$COLUMNS"s |tr " " "-"
    if [ -z "$1" ]      # Is parameter #1 zero length?
    then
        printf "     There was an error ... somewhere\n"  # no parameter passed.
    else
        printf "\n     Error Installing $1\n" # parameter passed.
    fi
    printf %"$COLUMNS"s |tr " " "-"
    printf " \e[0m\n"
}

printStep() {
    printf %"$COLUMNS"s |tr " " "-"
    printf "\nInstalling $1...\n";
    $2 || printError "$1"
}

command_exists() {
  command -v "$@" >/dev/null 2>&1
}

# Check that we're ready to run the install script
# This script is targeted mainly at a brand new install.
read -p "About to run the install script for a new computer - are you ready? [y/n] " -n 1 -r
echo

if [[ $REPLY =~ ^[Nn]$ ]]
then
  echo
  echo "See you later!"
  exit 1
fi

printHeading "Running the install script"
printDivider

printHeading "Installing xcode cli development tools"
printDivider
    xcode-select --install && \
        read -n 1 -r -s -p $'\n\nWhen Xcode cli tools are installed, press ANY KEY to continue...\n\n' || \
            printDivider && echo "✔ Xcode cli tools already installed. Skipping"
printDivider

if ! command_exists brew; then
  printHeading "Installing Homebrew..."
  printDivider
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  printDivider
fi

printCompletedStep "brew"

printHeading "Installing brew packages"
    printStep "git"                         "brew install git"
    printStep "coreutils"                   "brew install coreutils"
    printStep "github"                      "brew install gh"
printDivider

printHeading "Installing applications"
    if [[ -d "/Applications/Slack.app" ]]; then
        printDivider
        echo "✔ Slack already installed. Skipping"
    else
        printStep "Slack"                   "brew install --cask slack"
    fi

    if [[ -d "/Applications/Postman.app" ]]; then
        printDivider
        echo "✔ Postman already installed. Skipping"
    else
        printStep "Postman"                 "brew install --cask postman"
    fi

    if [[ -d "/Applications/Visual Studio Code.app" ]]; then
        printDivider
        echo "✔ Visual Studio Code already installed. Skipping"
    else
        printStep "VSCode"                  "brew install --cask visual-studio-code"
    fi

    if [[ -d "/Applications/iTerm.app" ]]; then
        printDivider
        echo "✔ Iterm2 already installed. Skipping"
    else
        printStep "iTerm2"                  "brew install --cask iterm2"
    fi

    if [[ -d "/Applications/Spotify.app" ]]; then
        printDivider
        echo "✔ Spotify already installed. Skipping"
    else
        printStep "Spotify"                  "brew install --cask spotify"
    fi

    if [[ -d "/Applications/Sequel Ace.app" ]]; then
        printDivider
        echo "✔ Sequel Ace already installed. Skipping"
    else
        printStep "Sequel Ace"                  "brew install --cask sequel-ace"
    fi
printDivider

printHeading "Setting up Git config..."
printDivider
    if [ -n "$(git config --global user.email)" ]; then
        echo "✔ Git email is set to $(git config --global user.email)"
    else
        read -p 'What is your Git email address?: ' gitEmail
        git config --global user.email "$gitEmail"
    fi
printDivider
    if [ -n "$(git config --global user.name)" ]; then
        echo "✔ Git display name is set to $(git config --global user.name)"
    else
        read -p 'What is your Git display name (Firstname Lastname)?: ' gitName
        git config --global user.name "$gitName"
    fi
printDivider
    if [ -n "$(git config --global core.editor)" ]; then
        echo "✔ Git commit editor is set to $(git config --global core.editor)"
    else
        echo "Setting git commit editor to VSCode"
        git config --global core.editor "code"
    fi
printDivider
    echo "✔ Configure git to always ssh when dealing with https github repos"
        git config --global url."git@github.com:".insteadOf https://github.com/
        # you can remove this change by editing your ~/.gitconfig file
printDivider

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  printHeading "Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  printDivider
fi

printCompletedStep "oh-my-zsh"

printHeading "Installing powerline fonts..."
  git clone https://github.com/powerline/fonts.git --depth=1
  cd fonts
  ./install.sh
  cd ..
  rm -rf fonts
printDivider

printHeading "Installing spaceship prompt..."
  export ZSH_CUSTOM="$HOME/.oh-my-zsh"
  git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
  ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
printDivider
printCompletedStep "spaceship prompt"

if ! command_exists asdf; then
  printHeading "Installing asdf..."
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf
  printDivider
fi
printCompletedStep "asdf"
printDivider

printHeading "Script Complete"
printDivider

tput setaf 2 # set text color to green
cat << "EOT"

   ╭─────────────────────────────────────────────────────────────────╮
   │░░░░░░░░░░░░░░░░░░░░░░░░░░░ Next Steps ░░░░░░░░░░░░░░░░░░░░░░░░░░│
   ├─────────────────────────────────────────────────────────────────┤
   │                                                                 │
   │               Setup almost complete! In ~/.zshrc                │
   │                                                                 │
   │   Add plugins=(z git git-prompt zsh-syntax-highlighting asdf)   │
   │                                                                 │
   └─────────────────────────────────────────────────────────────────┘

EOT
