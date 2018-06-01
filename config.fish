# https://fishshell.com/docs/current/faq.html

# Set default editor
set -U EDITOR nano

# locale settings
set -U LC_ALL en_US.UTF-8
set -U LC_CTYPE en_US.UTF-8

# NVM
# nvm installed via fisher

# Golang path
set -U GOPATH $HOME/Workspace/go

# Python pyenv
# pyenv installed via fisher
set -U WORKON_HOME $PYENV_ROOT/versions
set -U PROJECT_HOME $HOME/Workspace

# Rust path
set -x PATH $PATH $HOME/.cargo/bin

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
