fortune | cowsay | lolcat
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

fpath=($fpath $HOME/.custom-completions)

# Source Custom Rc files.
source $HOME/.gneiss_rc

export LC_ALL="en_US.UTF-8"

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
  fasd
)

export PATH=$(brew --prefix)/bin:$PATH
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH" 
source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(buffer-empty bracketed-paste accept-line push-line-or-edit)
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

eval "$(zoxide init zsh)"

alias l="exa --group-directories-first --icons"
alias ll="exa -lh --group-directories-first --icons --no-user --no-permissions" 
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
export FZF_COMPLETION_TRIGGER='~~'

# Options to fzf command
export FZF_COMPLETION_OPTS='--border --info=inline'

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

bindkey '^ ' forward-word

