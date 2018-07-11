# https://fishshell.com/docs/current/faq.html

# Set default editor
set -U EDITOR nano

# locale settings
set -gx LC_ALL en_US.UTF-8
set -gx LC_CTYPE en_US.UTF-8
set -gx LANG en_US.UTF-8

# NVM
# nvm installed via fisher

# Golang path
set -gx GOPATH $HOME/Workspace/go

# Rust path
set -x PATH $HOME/.cargo/bin $PATH

# Path to sqlite3
set -x PATH /usr/local/opt/sqlite/bin $PATH

set -g theme_display_nvm yes
set -g theme_display_rust yes

# emacs ansi-term support
if test -n "$EMACS"
    set -x TERM eterm-color
end

# this function may be required
function fish_title
    true
end
set -g fish_user_paths "/usr/local/sbin" $fish_user_paths

# Python pyenv
# pyenv installed via fisher
set -gx WORKON_HOME $PYENV_ROOT/versions
set -gx PROJECT_HOME $HOME/Workspace

# Pipsi settings
set -gx PIPSI_HOME $HOME/.pipsi/virtualenvs
set -gx PIPSI_BIN_DIR $HOME/.pipsi/bin
set -gx PATH $PIPSI_BIN_DIR $PATH

# added by pipsi (https://github.com/mitsuhiko/pipsi)
# set -x PATH /Users/parag-nbt/.pipsi/bin $PATH

