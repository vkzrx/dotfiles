function cdp --description 'List directories at `~/dev` and `cd` into selected one'
  builtin cd ~/dev

  set fd_cmd (command -v fd)
  set --append fd_cmd --type directory --max-depth 1 $fzf_fd_opts

  set fzf_arguments --multi $fzf_directory_opts
  set unescaped_exp_token (string unescape -- $expanded_token)
  set --prepend fzf_arguments --prompt="Search Directory" $unescaped_exp_token

  set target ($fd_cmd 2>/dev/null | _fzf_wrapper $_fzf_arguments)

  builtin cd $target
  ls
end
