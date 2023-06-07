export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="spaceship"

plugins=(z git git-prompt asdf zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

alias ..="cd .."
alias ...="cd ../.."
alias c="clear"
alias rm="rm -i"