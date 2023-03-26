. /usr/local/opt/asdf/libexec/asdf.sh
export BROWSER=firefox
export PATH=/Users/dan/.local/bin:$PATH
export PATH=$(yarn global bin):$PATH

export PGDATA=$(brew --prefix)/var/postgres

GIT_PROMPT_EXECUTABLE="haskell"
source ~/dev/zsh-git-prompt/zshrc.sh
PROMPT='%~%b $(git_super_status)> '

alias g="git"
alias gco="git checkout"
alias gpl="git pull"
alias gps="git push"
alias gs="git status"

alias current_branch="git symbolic-ref -q HEAD | cut -c 12-"
alias gpsu='git push -u origin "$(current_branch)"'

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/dan/dev/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/dan/dev/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/dan/dev/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/dan/dev/google-cloud-sdk/completion.zsh.inc'; fi

# docker thing apparently
export UID
