source $ZSH/oh-my-zsh.sh

# Plugins
plugins=(brew cake colorize coffee docker web-search encode64 gem git osx rails rvm sublime ruby github node npm zsh-syntax-highlighting vagrant colored-man)

# Aliases
alias elm='docker run -it --rm -v "$(pwd):/code" -w "/code" -e "HOME=/tmp" -u $UID:$GID -p 8000:8000 codesimple/elm:0.17'
alias zconfig="nano ~/.zshrc"
alias ohmyzsh="nano ~/.oh-my-zsh"
alias docker_rm_all="docker rm `docker ps -a -q`"
