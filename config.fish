# https://fishshell.com/docs/current/faq.html
set -gx PATH $fish_user_paths
set -g fish_user_paths "/usr/local/sbin" $fish_user_paths

# Set default editor
set -U EDITOR nano

# locale settings
set -gx LC_ALL en_US.UTF-8
set -gx LC_CTYPE en_US.UTF-8
set -gx LANG en_US.UTF-8

# Gitlab
set -gx GITLAB_PROJECT_TOKEN pNdAKYN5jMZwbegFoiHn
set -gx GITLAB_USERID 1486497

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
#set -g fish_user_paths "/usr/local/sbin" $fish_user_paths

# Python

# llvm settings
#set -g fish_user_paths "/usr/local/opt/llvm/bin" $fish_user_paths

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.fish ]; and . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.fish
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.fish ]; and . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.fish

# added by Anaconda3 2018.12 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
# set __conda_setup (env CONDA_REPORT_ERRORS=false '~/Workspace/vendor/anaconda3/bin/conda' shell.bash hook 2> /dev/null)
# if test "$status" -eq 0
#     eval "$__conda_setup"
# else
#     if test -f "~/Workspace/vendor/anaconda3/etc/profile.d/conda.sh"
#         . "~/Workspace/vendor/anaconda3/etc/profile.d/conda.sh"
#         env CONDA_CHANGEPS1=false conda activate base
#     else
#         set -gx PATH $HOME/Workspace/vendor/anaconda3/bin $PATH
#     end
# end
# set -e __conda_setup
# <<< conda init <<<
