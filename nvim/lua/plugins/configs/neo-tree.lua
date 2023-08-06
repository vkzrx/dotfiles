local options = {
  close_if_last_window = false,
  enable_git_status = true,
  enable_diagnostics = true,
  filesystem = {
    follow_current_file = {
      enabled = true,
      leave_dirs_open = true,
    },
    filtered_items = {
      hide_dotfiles = false,
      never_show = '.DS_Store',
    },
  }
}

return options
