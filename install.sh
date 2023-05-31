# Sets zsh to be the default shell when connecting over ssh
sudo chsh "$(id -un)" --shell "/usr/bin/zsh"

# Installs spaceship font for zsh
export ZSH_CUSTOM="$HOME/.oh-my-zsh"
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

# Sets Git config values
git config --global core.editor "code"

source $HOME/.zshrc