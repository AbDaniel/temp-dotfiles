
alias cwd='echo -n "$(pwd)" | pbcopy'
alias sc='simcloud'
alias sls="simcloud -q job ls -f '{{.ID}} {{.Status}} {{(index .Tasks 0).ExitCode}} {{.JobSpec.Tags}}'"   

bundleselect() {
  simcloud bundle ls | fzf | awk '{print $1}' | tr -d '\n' | pbcopy
}

# alias job_select="simcloud job ls | fzf | awk '{print $1}' | pbcopy "
# alias volume_select="simcloud volume ls | fzf | awk '{print $1}' | pbcopy "

fsc() {
  local command="$1"
  local subcommand="$2"
  shift 2

  simcloud $command ls "$@" | fzf | awk '{print $1}'  | xargs -I {} simcloud job $subcommand {}
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

