if status is-interactive
and not set -q TMUX
  exec tmux
end

# disable default greeting
set -g fish_greeting

set -gx EDITOR nvim

fish_add_path /usr/local/bin
fish_add_path ~/.local/bin
fish_add_path /opt/homebrew/bin
fish_add_path ~/.yarn/bin
fish_add_path ~/.cargo/bin
# fish_add_path ~/Library/pnpm
fish_add_path /usr/local/go/bin
fish_add_path ~/go/bin
set GOPATH ~/go

alias ls="exa -l"
alias ..="cd .."
alias ...="cd ../.."
alias v="nvim"
alias gs="git status"
alias gck="git branch --all | fzf --height 25% | xargs git checkout"
alias lg="lazygit"

fzf_configure_bindings --directory=\cp
set fzf_directory_opts --bind "enter:execute(nvim {} &> /dev/tty)+abort"
set fzf_fd_opts --type f --hidden --exclude=.git

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# zoxide init fish | source
starship init fish | source
