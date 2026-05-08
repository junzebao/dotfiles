if not status is-interactive
    exit
end

set -gx EDITOR nvim
fish_add_path $HOME/.local/bin

alias v=nvim

# Plugin equivalents from oh-my-zsh (git, macos, zoxide, kubectl, helm):
# - git: fish ships with git completions; install plugin-git via Fisher for aliases
# - macos: install plugin-osx via Fisher if you want the helper functions

# fzf
if type -q fzf
    fzf --fish | source
end

# zoxide
if type -q zoxide
    zoxide init fish | source
end

# starship prompt
if type -q starship
    starship init fish | source
end
