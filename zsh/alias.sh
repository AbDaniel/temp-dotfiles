
alias cwd='echo -n "$(pwd)" | pbcopy'
alias sc='simcloud'
alias sls="simcloud -q job ls -f '{{.ID}} {{.Status}} {{(index .Tasks 0).ExitCode}} {{.JobSpec.Tags}}'"   

