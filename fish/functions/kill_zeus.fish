function kill_zeus
  kill -9 (ps aux | grep zeus | sed '/tmux/d' | sed '/grep/d' | sed -e 's/^[a-z ]*\([0-9]*\).*$/\1/g')
  if test $status -eq 0
    printf "Deicide! ⚡  💀\n"
  else
    printf "Already dead  💀 \n"
  end
end
