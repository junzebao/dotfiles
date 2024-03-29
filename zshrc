# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export VISUAL=nvim
export EDITOR="$VISUAL"
export BAT_THEME="gruvbox-dark"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="/usr/local/opt/curl/bin:$PATH"

# Path to your oh-my-zsh installation.
export ZSH="/Users/junze/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git osx autojump zsh-autosuggestions fast-syntax-highlighting fancy-ctrl-z terraform kubectl helm)

source $ZSH/oh-my-zsh.sh

# User configuration
export SSH_AUTH_SOCK=/Users/junze/.ssh/agent

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f ~/.alias ] && source ~/.alias

function change_env {
    export AWS_PROFILE=tutti-$1;
    export STACK=$1;
    if [ $1 != sysops -a $1 != backup ]; then
        aws eks --region eu-central-1 update-kubeconfig --name $1__cluster;
        kcn tutti-services;
        aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin `aws sts get-caller-identity | jq -r .Account`.dkr.ecr.eu-central-1.amazonaws.com
        if [ -d .terraform ]; then
            tf workspace select $1;
        fi
    fi
}
