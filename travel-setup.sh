#!/bin/bash
set -o nounset
set -o errexit
set -o pipefail

export $(egrep -v '^#' .env | xargs)
export LANG=en_US.UTF-8

DROPBOX_DOWNLOAD_API="https://content.dropboxapi.com/2/files/download"
MYTRAVELAPI_TOKEN=${MYTRAVELAPI_TOKEN}
GITHUB_PERSONAL_TOKEN=${GITHUB_PERSONAL_TOKEN}
GITLAB_PERSONAL_TOKEN=${GITLAB_PERSONAL_TOKEN}
WORK_EMAIL=${WORK_EMAIL}
TIMEZONE=${TIMEZONE:-Europe/Berlin}

function set_password() {
    if [[ -x "$(command -v lsb_release)" ]]; then
        sudo passwd ubuntu
    elif [[ -x "$(command -v emerge)" ]]; then
        sudo passwd
    fi
}

function install() {
    if [[ -n "$(command -v apt-get)" ]]; then
       sudo apt-get install -y --no-install-recommends "${@}"
    elif [[ -n "$(command -v apt-get)" ]]; then
        emerge "${@}"
    fi
}

# Taken from https://unix.stackexchange.com/questions/125819/bash-function-decorator
function decorate() {
    eval "
    _inner_$(typeset -f "$1")
    $1"'() {
      printf "\n\n"
      echo >&2 "Running '"$1"'..."
      echo "=============================="
      _inner_'"$1"' "$@"
      local ret=$?
      echo >&2 "Function '"$1"' returned with exit status $ret"
      return "$ret"
    }'
}


function environment() {
    [ -d "~/Workspace" ] && echo "Workspace is mounted/ready" || $(echo "Please run 'sudo mount -t ntfs /dev/nvme0n1pX $HOME/Workspace"; exit 1)
    if [ -z "${MYTRAVELAPI_TOKEN+x}" ]; then echo "Please set MYTRAVELAPI_TOKEN=token" && exit 1; else echo "Using token $MYTRAVELAPI_TOKEN"; fi
}
decorate environment


function essentials() {
    install \
      build-essential \
      iputils-ping \
      curl wget \
      iptables \
      psmisc \
      libpq-dev postgresql-client \
      python3-pip \
      zip unzip \
      openssh-client \
      git \
      stow \
      tzdata
}
decorate essentials


function locale() {
    install locales locales-all
    echo "$LANG UTF-8" | sudo tee /etc/locale.gen \
      && sudo locale-gen $LANG \
      && sudo update-locale LANG=$LANG LC_CTYPE=$LANG
}
decorate locale


function timezone() {
    sudo ln -fs /usr/share/zoneinfo/${TIMEZONE} /etc/localtime
    sudo dpkg-reconfigure --frontend noninteractive tzdata
}
decorate timezone


function ssh() {
    curl -X POST ${DROPBOX_DOWNLOAD_API} \
         --header "Authorization: Bearer ${MYTRAVELAPI_TOKEN}" \
         --header "Dropbox-API-Arg: {\"path\": \"/Documents/travel/id_travel\"}" > ~/.ssh/id_travel
    chmod 400  ~/.ssh/id_travel
    eval $(ssh-agent)
    ssh-add ~/.ssh/id_travel
}
decorate ssh


function code_workspace() {
    mkdir -p $1 ${1}/play ${1}/work ${1}/vendor
    [ -d "${1}/_" ] && echo "_ exists" || git clone https://gitlab-ci-token:${GITLAB_PERSONAL_TOKEN}@gitlab.com/parag_m/knowledge.git ${1}/_
    cd ${1}/_ && git pull origin master && cd -
}
decorate code_workspace


function clone_dotfiles() {
    [ -d "${1}/dotfiles" ] && echo "dotfiles exists" || git clone https://gitlab-ci-token:${GITLAB_PERSONAL_TOKEN}@gitlab.com/parag_m/dotfiles.git ${1}/dotfiles
    cd ${1}/dotfiles && git pull origin master && cd -
}
decorate clone_dotfiles


function dot_zsh() {
    dotfiles=${1}
    install zsh
    rm -rf $HOME/.oh-my-zsh
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    stow -d $dotfiles -vRt ~ zsh

    cat <<EOS > ~/.zshenv
source ~/.zshenv.common
export GITLAB_CLI_TOKEN=${GITLAB_PERSONAL_TOKEN}
export GITLAB_USER_PARAG=
EOS

    cat <<EOS > ~/.zshrc
source \$ZSH/oh-my-zsh.sh
source ~/.zshrc.common
EOS
}
decorate dot_zsh


function dot_dircolors() {
    dotfiles=${1}
    stow -d $dotfiles -vRt ~ dircolors
    if ! grep -qF "/mnt/dev" /etc/fstab; then
        echo "/dev/sda1 /mnt/dev ext4 defaults 0 0" | sudo tee -a /etc/fstab
    fi

    echo "test -r \"~/.dir_colors\" && eval $(dircolors ~/.dir_colors)" >> ~/.zshrc
}
decorate dot_dircolors


function dot_gitconfig() {
    dotfiles=${1}
    w=${2} # Workspace root
    stow -d $dotfiles -vRt ~ gitconfig
    cat <<EOS > ~/.gitconfig-work
[user]
    name = Parag M.
    email = ${WORK_EMAIL}
EOS
}
decorate dot_gitconfig


function emacs() {
    install emacs-gtk
}
decorate emacs


function spacemacs() {
    dotfiles=${1}
    mv ~/.emacs.d ~/.emacs.d.backup
    git clone -b develop https://github.com/syl20bnr/spacemacs ~/.emacs.d
    stow -d $dotfiles -vRt ~ emacs
    setxkbmap -option 'ctrl:nocaps'
}
decorate spacemacs

function security() {
    install keepassxc
}
decorate security

# =====================================
# Execution starts here
# =====================================
#set_password

#essentials

#locale

#timezone

WORKSPACE_ROOT=$HOME/Workspace

code_workspace ${WORKSPACE_ROOT}

clone_dotfiles ${WORKSPACE_ROOT}/play

DOTREPO=${WORKSPACE_ROOT}/play/dotfiles
dot_zsh $DOTREPO
dot_dircolors $DOTREPO
dot_gitconfig $DOTREPO $WORKSPACE_ROOT

DOTREPO=${WORKSPACE_ROOT}/play/dotfiles
emacs
spacemacs $DOTREPO

echo "==> Fin"
echo "Run chsh -s /bin/zsh"
