
alias zshconfig="${EDITOR} ~/.zshrc"
alias cls="clear"
alias aliasconfig="$EDITOR ~/dotfiles/alias.sh"
alias ls="eza"

alias cwd='echo -n "$(pwd)" | pbcopy'
alias sc='simcloud'
alias sls="simcloud -q job ls -f '{{.ID}} {{.Status}} {{(index .Tasks 0).ExitCode}} {{.JobSpec.Tags}}'"   
alias timeit="hyperfine"

alias l="eza --group-directories-first --icons"
alias ll="eza -lh --group-directories-first --icons --no-user --no-permissions"
alias tree="\
	eza --tree --level=2 \
	--icons --time-style=long-iso --group-directories-first \
"

if command -v bat > /dev/null; then
	alias cat="bat"
elif command -v batcat ? /dev/null; then
	alias cat="batcat"
fi

alias zshconfig="${EDITOR} ~/.zshrc"
alias cls="clear"


scb() {
  result=$(simcloud bundle list -f json | jq -r '.[] | [.id, .tag, .ctime] | @tsv' | column -t | tac | fzf)
  id=$(echo $result | cut -d ' ' -f1)
  echo $id | tr -d '\n' | pbcopy
  echo "copied: $id"
}


fcp() {
  fd . | fzf --preview 'bat --color "always" {}' \
  | awk -v pwd="$PWD" '{if ($0 !~ /^\//) print pwd"/"$0; else print $0}' \
  | tr -d '\n' \
  | tee >(pbcopy) \
  | awk '{print "copied: "$0}'
}


bundleselect() {
  simcloud bundle ls | fzf | awk '{print $1}' | tr -d '\n' | pbcopy
}

# alias job_select="simcloud job ls | fzf | awk '{print $1}' | pbcopy "
# alias volume_select="simcloud volume ls | fzf | awk '{print $1}' | pbcopy "

# fsc() {
#   local command="$1"
#   local subcommand="$2"
#   shift 2
#
#   simcloud $command ls --sort created "$@" | fzf -m | awk '{print $1}'  | xargs -I {} simcloud job $subcommand {}
# }

# set -x
# 


unzipd() {
    # Get the zip file name without extension
    local folder_name="${1%.zip}"

    # Create the folder if it doesn't exist
    mkdir -p "$folder_name"

    # Unzip the file into the folder
    unzip "$1" -d "$folder_name"
}


fsc() {
  local command="$1"
  local subcommand="$2"
  local options=""
  local pre_process=""
  shift 2

  case "${command}" in
    "job")
        options="-f json"
        pre_process="mlr --j2p flatten \
              then cut -o -f id,status,resources.cpu,resources.gpu,times.created,tags.1,tags.2 \
              then rename resources.cpu,cpu,resources.gpu,gpu,times.created,created \
              then put '\
                \$created = gmt2sec(\$created);\
                now = systime();\
                diff = now - (\$created);\
                days = diff // 86400;\
                if (days == 0) {\
                  \$created = \"today\";\
                } elif (days == 1) {\
                  \$created = \"1 day ago\";\
                } else {\
                  \$created = days . \" days ago\";\
                }'"
        cmd="mlr --j2p flatten \
          then cut -o -f id,status,resources.cpu,resources.gpu,times.created,tags.1,tags.2 \
          then rename resources.cpu,cpu,resources.gpu,gpu,times.created,created \
          put '\$created_s = strptime(\$created, \"%Y-%m-%d\")'"
        ;;
    "bundle")
        options="-f csv"
        pre_process="mlr --c2p sort -nr ctime then cut -o -f id,tag,ctime,size"
        ;;
    # add more conditions here
  esac
  
  local selected_item=$(
    if [ -z "$pre_process" ]; then
      simcloud $command ls $options "$@" | fzf | awk '{print $1}'
    else
      sh -c "simcloud $command ls $options $@" | sh -c "$pre_process" | fzf | awk '{print $1}'
    fi)
                        
  final_command="simcloud $command $subcommand $selected_item"
  # Put the final command into the Zsh command line
  print -z "$final_command"       
}


tm() {
  tmux popup -E "$@"
}

untar() {
  if [ -z "$1" ]; then
    echo "Please provide the tar.gz file as an argument."
    return 1
  fi
  
  if [ ! -f "$1" ]; then
    echo "File not found: $1"
    return 1
  fi
  
  # Extract the base name of the file (without extension)
  filename=$(basename "$1")
  filename="${filename%.*}"
  
  # Create the destination directory if it doesn't exist
  mkdir -p "$filename"
  
  # Extract the files into the directory
  tar -xzf "$1" -C "$filename"
  
  echo "Extraction completed successfully."
}


alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'
