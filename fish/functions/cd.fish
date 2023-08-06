function cd --description 'Change directory and list contents'
  if test -z "$argv"
    builtin cd $HOME
  else
    builtin cd $argv
  end
  ls
end
