export ZSH="~/.oh-my-zsh"

source $ZSH/oh-my-zsh.sh

ZSH_THEME="spaceship"

plugins=(zsh-z git git-prompt zsh-syntax-highlighting)

## General Aliases
alias c="clear"
alias be="bundle exec"
alias rm="rm -i"
alias zr="z -r"
alias tf="tail -f"
alias gs="git status"
alias zshconfig="vim ~/.zshrc"
