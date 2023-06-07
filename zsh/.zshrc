# fortune | cowsay | lolcat
fortune | cowsay -f $(ls /opt/homebrew/Cellar/cowsay/3.04_1/share/cows | shuf -n1) |  lolcat
# fortune | pokemonsay
#
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# fpath=($fpath $HOME/.custom-completions)

export LC_ALL="en_US.UTF-8"

# alias nvim='lvim'
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
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
)

export PATH=$(brew --prefix)/bin:$PATH
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH" 
# export PATH="/Users/abrahamdanielimmanualwilliams/.local/bin:$PATH"

source $ZSH/oh-my-zsh.sh

HISTFILE=~/.zsh_history
HISTSIZE=999999999
SAVEHIST=$HISTSIZE

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

alias l="exa --group-directories-first --icons"
alias ll="exa -lh --group-directories-first --icons --no-user --no-permissions -a"
alias tree="\
	exa --tree --level=2 \
	--icons --time-style=long-iso --group-directories-first \
"

if command -v bat > /dev/null; then
	alias cat="bat"
elif command -v batcat ? /dev/null; then
	alias cat="batcat"
fi

alias zshconfig="${EDITOR} ~/.zshrc"
alias cls="clear"

ZVM_VI_INSERT_ESCAPE_BINDKEY=jk

zvm_after_init_commands+=('[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh')

eval $(thefuck --alias)

# Use ~~ as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER='``'

# Options to fzf command
export FZF_COMPLETION_OPTS='--border --info=inline'

export FZF_ALT_C_OPTS="--preview 'tree -C {}'"

# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_OPTS="
  --preview 'bat --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# CTRL-/ to toggle small preview window to see the full command
# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  --preview 'echo {}' --preview-window up:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --follow --exclude ".git" . "$1"
}

# (EXPERIMENTAL) Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf "$@" --preview 'tree -C {} | head -200' ;;
    export|unset) fzf "$@" --preview "eval 'echo \$'{}" ;;
    ssh)          fzf "$@" --preview 'dig {}' ;; 
    *)            fzf "$@" ;;
  esac
}

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


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


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


conda deactivate

mcd() { mkdir "$@" 2> >(sed s/mkdir/mcd/ 1>&2) && cd "$_"; }

# custom rc files
source ~/.gneiss_rc
source ~/dotfiles/zsh//alias.sh
source ~/dotfiles/env.sh
source ~/dotfiles/fzf.sh


# completions for brew
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi


# EXA color theme
LS_COLORS="$(vivid generate snazzy)"

