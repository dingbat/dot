##
# Aliases
#
alias "redis-server"="redis-server /usr/local/etc/redis.conf"
alias c="clear"

alias subl="reattach-to-user-namespace subl"

alias current_branch="git symbolic-ref -q HEAD | cut -c 12-"

abbr -a gco "git checkout"

alias delete_swap="find . -type f -name '*.sw[klmnop]' -delete"

alias be="bundle exec"

alias v="vim"
alias vi="vim"
alias z="zeus"
alias zc="zeus c"
alias zr="zeus rake"

alias g="git"
alias gs="git status"
alias gl="git log"
alias gps="git push"
alias gpl="git pull"
alias gc="git commit -m"
alias gb="git branch"
alias gm="git merge"
alias ga="git add"
alias gd="git diff"
alias gca="git add .; and git commit -m"
alias gu="git unstage"
alias gcf="git commit --amend --no-edit"
alias gpsu="git push -u origin (current_branch)"

alias fr='foreman run'
alias fs='foreman start'

abbr -a ignore_delayed 'awk "!/Delayed::Backend/ && !/delayed_jobs/"'

alias android-shake 'adb shell input keyevent 82'
alias android-inet 'adb reverse tcp:8081 tcp:8081'

alias pg-start="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
alias pg-stop="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log stop"

##
# Styling, greeting, and prompt
#

set fish_color_command 6EADFF
set fish_color_param 84B229

function fish_greeting
  # New shells
  echo "Hi Dan! ☯"
  black_hole
  echo
end

function fish_prompt
  set_color -o yellow
  echo -n (prompt_pwd)
  set_color white

  __informative_git_prompt

  set_color white
  echo -n '> '
end

function fish_right_prompt
  set -l last_status $status

  # Print a red dot for failed commands.
  if test $last_status -gt 0
    set_color red;    echo -n "•"
    set_color normal; echo -n " "
  end
end

# Postgres
set -g PGHOST "localhost"
set -g ANDROID_HOME "/Users/dan/Library/Android/sdk"

##
# Env/path stuff
#

set -g EDITOR "vim"

set -g GOPATH "/Users/dan/go"

set -g PATH "$ANDROID_HOME/tools" $PATH
set -g PATH "$ANDROID_HOME/platform-tools" $PATH

set -g PATH "/Users/dan/.cabal/bin" $PATH
set -g PATH "/Users/dan/.ghcup/bin" $PATH
# source "/Users/dan/.ghcup/env"

set -g fish_user_paths "/usr/local/opt/postgresql/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/node@12/bin" $fish_user_paths

# rbenv
status --is-interactive; and source (rbenv init -|psub)
set -g fish_user_paths "/usr/local/opt/qt@5.5/bin" $fish_user_paths
set -g fish_user_paths "/Users/dan/.config/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/icu4c/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/icu4c/sbin" $fish_user_paths
set -g fish_user_paths "/usr/local/sbin" $fish_user_paths

# set -g LIBRARY_PATH "/usr/local/opt/openssl/lib/" $LIBRARY_PATH
