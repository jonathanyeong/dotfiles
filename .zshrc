export ZSH="$HOME/.oh-my-zsh"
eval "$(starship init zsh)"

plugins=(z git git-prompt zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

alias ..="cd .."
alias ...="cd ../.."
alias c="clear"
alias rm="rm -i"