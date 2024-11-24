# fortune | cowsay | lolcat
fortune | cowsay -f $(ls /opt/homebrew/Cellar/cowsay/3.04_1/share/cows/*.cow | shuf -n1) |  lolcat
#
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# fpath=($fpath $HOME/.custom-completions)

export LC_ALL="en_US.UTF-8"

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  alias vim='nvim'
  export EDITOR='nvim'
fi
############ OH my stuff ##################

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  # Needs to be first.
  # zsh-autocomplete
  brew
  common-aliases
  # autoenv
  compleat
  git
  git-extras
  git-auto-fetch
  gradle-completion

  zsh-autosuggestions
  fzf-tab
  zsh-history-substring-search
  zsh-vi-mode
  zoxide
  # fzf
  aliases

  # # Must be last
  F-Sy-H
  # # zsh-syntax-highlighting
  thefuck

  forgit
  conda-zsh-completion
  # autoenv

  kubectl
  poetry
  docker
)

export PATH=$(brew --prefix)/bin:$PATH
export PATH=$(brew --prefix)/sbin:$PATH
export PATH="$(brew --prefix)/opt/python@3/libexec/bin:$PATH"
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH" 
# export PATH="/Users/abrahamdanielimmanualwilliams/.local/bin:$PATH"

source $ZSH/oh-my-zsh.sh

HISTFILE=~/.zsh_history
HISTSIZE=999999999
SAVEHIST=$HISTSIZE
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(
  history-search-forward
  history-search-backward
  history-beginning-search-forward
  history-beginning-search-backward
  history-substring-search-up
  history-substring-search-down
  up-line-or-beginning-search
  down-line-or-beginning-search
  up-line-or-history
  down-line-or-history
  accept-line
  copy-earlier-word
  bracketed-paste
)

ZSH_AUTOSUGGEST_STRATEGY=(history)

eval "$(zoxide init zsh)"

ZVM_VI_INSERT_ESCAPE_BINDKEY=jk

zvm_after_init_commands+=('[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh')

eval $(thefuck --alias)

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
unalias imgcat
function zvm_vi_yank() {
	zvm_yank
	printf %s ${CUTBUFFER} | pbcopy
	zvm_exit_visual_mode
}

zvm_after_init_commands+=("bindkey '^ ' forward-word")

# start up steps.
# cd ~/Workspace/gneiss-data
# ./setup.sh > logs/setup-script.log 2>&1
# z
## end of setup

mcd() { mkdir "$@" 2> >(sed s/mkdir/mcd/ 1>&2) && cd "$_"; }

# custom rc files
source ~/.gneiss_rc
source ~/dotfiles/alias.sh
source ~/dotfiles/env.sh
source ~/dotfiles/fzf.sh
source ~/.frontiere_rc
source ~/dotfiles/yazi.sh
# source ~/dotfiles-apple/isds_rc


# completions for brew
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi


# EXA color theme
LS_COLORS="$(vivid generate snazzy)"

export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${HOME}/Library/Application Support/JetBrains/Toolbox/scripts"
# export PATH="$PATH:${HOME}/go/bin"

setopt append_history
setopt inc_append_history

# alias python3=/opt/homebrew/bin/python3
# OPTIONAL: ensure "python" command uses homebrew's version of python3
# alias python=/opt/homebrew/bin/python3

export KIND_EXPERIMENTAL_PROVIDER=docker
export K9S_CONFIG_DIR="${HOME}/.config/k9s"


# homebrew
export HOMEBREW_NO_AUTO_UPDATE=1

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export PIPX_HOME=$HOME/.local/pipx

zstyle ':completion:*' menu select
fpath+=~/.zfunc

export PATH="/opt/homebrew/opt/openssl@1.0/bin:$PATH"
export TEMPORAL_DEBUG=1
export PATH="/opt/homebrew/opt/node@20/bin:$PATH"

. "$HOME/.cargo/env"
[[ :$PATH: == *:$HOME/bin:* ]] || PATH=$HOME/bin:$PATH
source <(capri --zsh-completions 2>/dev/null)
source <(isc --zsh-completions 2>/dev/null)
source <(acc --zsh-completions 2>/dev/null)
export PATH="/opt/homebrew/opt/postgresql@13/bin:$PATH"
export DOCKER_DEFAULT_PLATFORM=linux/arm64
export ERG_PATH=/Users/abrahamdanielimmanualwilliams/.cargo/bin/erg
