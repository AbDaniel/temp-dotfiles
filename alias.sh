
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



