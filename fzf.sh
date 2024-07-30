# FZF config + custom completions. 
#
# TODO: Move fzf config stuff out of zshrc


export FZF_DEFAULT_OPTS="--height=60% --layout=reverse --inline-info"

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
    simcloud)     fzf "$@" ;; 
    *)            fzf "$@" --preview 'bat --color=always {}' ;;
  esac
}



# FZF - Tab conf. from their github examples
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath' # remember to use single quote here!!!
# give a preview of commandline arguments when completing `kill`
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview '[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap

zstyle ':fzf-tab:complete:simcloud:*' disabled-on any 

_fzf_complete_simcloud() {
  local command=$(echo ${1} | awk {'print $2'})
  # echo $command >> ~/out.log


FZF_COMPLETION_TRIGGER='' _fzf_complete -- "$@" < <(simcloud $command list --owner=iss:apps:news:gneiss --owner=abraham_williams --owner=iss:abraham_williams --owner=p6:iss:abraham_williams)
}


_fzf_complete_simcloud_post() {
    awk '{print $1}'
}


envfzf() {
    selected_var=$(env | fzf --height 40% --border --ansi --preview 'echo {} | cut -d "=" -f 1 | xargs -I{} printenv {}')
    
    if [ -n "$selected_var" ]; then
        echo "Selected Variable: $selected_var"
        echo "$selected_var" | pbcopy
        echo "Copied to clipboard."
    else
        echo "No variable selected."
    fi
}


# -------- Docker(https://github.com/pierpo/fzf-docker.git) --------------
FZF_DOCKER_PS_FORMAT="table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.Ports}}"
FZF_DOCKER_PS_START_FORMAT="table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Image}}"

_fzf_complete_docker() {
  # Get all Docker commands
  #
  # Cut below "Management Commands:", then exclude "Management Commands:",
  # "Commands:" and the last line of the help. Then keep the first column and
  # delete empty lines
  DOCKER_COMMANDS=$(docker --help 2>&1 >/dev/null |
    sed -n -e '/Management Commands:/,$p' |
    grep -v "Management Commands:" |
    grep -v "Commands:" |
    grep -v 'COMMAND --help' |
    grep .
  )

  ARGS="$@"
  if [[ $ARGS == 'docker ' ]]; then
    _fzf_complete "--reverse -n 1 --height=80%" "$@" < <(
      echo $DOCKER_COMMANDS
    )
  elif [[ $ARGS == 'docker tag'* || $ARGS == 'docker -f'* || $ARGS == 'docker run'* || $ARGS == 'docker push'* ]]; then
    _fzf_complete "--multi --header-lines=1" "$@" < <(
      docker images --format "table {{.Repository}}:{{.Tag}}\t{{.Size}}\t{{.ID}}\t{{.CreatedSince}}"
    )
  elif [[ $ARGS == 'docker rmi'* ]]; then
    _fzf_complete "--multi --header-lines=1" "$@" < <(
      docker images --format "table {{.ID}}\t{{.Repository}}\t{{.Tag}}\t{{.Size}}"
    )
  elif [[ $ARGS == 'docker stop'* || $ARGS == 'docker exec'* || $ARGS == 'docker kill'* || $ARGS == 'docker restart'* || $ARGS == 'docker logs'* ]]; then
    _fzf_complete "--multi --header-lines=1 " "$@" < <(
      docker ps --format "${FZF_DOCKER_PS_FORMAT}"
    )
  elif [[ $ARGS == 'docker rm'* ]]; then
    _fzf_complete "--multi --header-lines=1 " "$@" < <(
      docker ps -a --format "${FZF_DOCKER_PS_FORMAT}"
  )
  elif [[ $ARGS == 'docker start'* ]]; then
     _fzf_complete "--multi --header-lines=1 " "$@" < <(
      docker ps -a --format "${FZF_DOCKER_PS_START_FORMAT}"
    )
  fi
}

_fzf_complete_docker_post() {
  # Post-process the fzf output to keep only the command name and not the explanation with it
  awk '{print $1}'
}

[ -n "$BASH" ] && complete -F _fzf_complete_docker -o default -o bashdefault docker
