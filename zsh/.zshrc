
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"
ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

plugins=(git)
source $ZSH/oh-my-zsh.sh


source $ZSH_CUSTOM/aliases.zsh
source $ZSH_CUSTOM/macos.zsh

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
