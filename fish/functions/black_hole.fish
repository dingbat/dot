function black_hole
  set out "\n"
  for x in (seq 4)
    set out "$out"'   '
    if [ $x != 4 -a $x != 1 ]
      for y in (seq (math (random)' %1'))
        set out "$out"' '
      end
    end
    for y in (seq (math 15 + (random)' %1'))
      set -l rand (math (random)'%16')
      if [ $rand -lt 3 ]
        set out "$out"','
      else if [ $rand -lt 7 ]
        set out "$out"'.'
      else if [ $rand -lt 9 ]
        set out "$out"'+'
      else if [ $rand -lt 11 ]
        set out "$out"'@'
      else if [ $rand -lt 12 ]
        set out "$out"'*'
      else if [ $rand -lt 14 ]
        set out "$out"' '
      else if [ $rand -lt 15 ]
        set out "$out"':'
      else if [ $rand -lt 16 ]
        set out "$out"'W'
      end
    end
    set out "$out""\n"
  end
  printf $out"\n"
end
