# FZF config + custom completions. 
#
# TODO: Move fzf config stuff out of zshrc

# FZF - confs
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath' # remember to use single quote here!!!
# give a preview of commandline arguments when completing `kill`
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview '[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap

zstyle ':fzf-tab:complete:simcloud:*' disabled-on any 

_fzf_complete_simcloud() {
  local command=$(echo ${1} | awk {'print $2'})
  echo $command >> ~/out.log
  
  FZF_COMPLETION_TRIGGER='' _fzf_complete -- "$@" < <(simcloud $command list)
}


# _fzf_complete_simcloud-job() {
#   _fzf_complete -- "$@" < <(
#     simcloud job list
#   )
# }


_fzf_complete_simcloud_post() {
    awk '{print $1}'
}
