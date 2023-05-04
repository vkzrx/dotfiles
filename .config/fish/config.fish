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
fish_add_path /usr/local/go/bin
fish_add_path ~/go/bin
set GOPATH ~/go

alias ls="exa -l"
alias ..="cd .."
alias ...="cd ../.."
alias nvim="lvim"
alias v="nvim"
alias pp="cd ~/dev"
alias gs="git status"
alias gck="git branch --all | fzf --height 25% | xargs git checkout"
# alias gck="_fzf_git_branches | xargs git checkout"
alias lg="lazygit"

## !!Those are for bash/zsh. Need to find the fish equivalent.
### FZF
# export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden -E .git -E node_modules -E dist -E build -E target -E .next -E .svelte-kit'

#export FZF_CTRL_R_OPTS="
#  --preview 'echo {}' --preview-window up:3:hidden:wrap
#  --bind 'ctrl-/:toggle-preview'
#  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
#  --color header:italic
#  --header 'Press CTRL-Y to copy command into clipboard'"

# bind \cp 'fzf --preview "bat --color=always --style=numbers --line-range=:500 {}" --height 50% --bind "enter:execute(lvim {})+abort"'

fzf_configure_bindings --directory=\cp
set fzf_directory_opts --bind "enter:execute(nvim {} &> /dev/tty)+abort"

zoxide init fish | source
starship init fish | source
