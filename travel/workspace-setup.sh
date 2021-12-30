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
SPOTIFY_CLIENT_ID=${SPOTIFY_CLIENT_ID}
SPOTIFY_CLIENT_SECRET=${SPOTIFY_CLIENT_SECRET}
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
       sudo apt-get install -y --no-install-recommends "$@"
    elif [[ -n "$(command -v apt-get)" ]]; then
        emerge "$@"
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

function os() {
    return $(uname -s | tr '[:upper:]' '[:lower:]')
}

function distro() {
    # Check for "ubuntu"
    if [[ -x "$(command -v lsb_release)" ]]; then
        if [[ "$1" == $(lsb_release -is | tr '[:upper:]' '[:lower:]') ]]; then
            echo "correct"
            return 0
        else
            echo "not match"
            return -1
        fi
    fi
}

function arch() {
    return $(uname -p)
}

function environment() {
    [ -d "~/Workspace" ] && echo "Workspace is mounted/ready" || $(echo "Please run 'sudo mount -t ntfs /dev/nvme0n1pX $HOME/Workspace"; exit 1)
    if [ -z "${MYTRAVELAPI_TOKEN+x}" ]; then echo "Please set MYTRAVELAPI_TOKEN=token" && exit 1; else echo "Using token $MYTRAVELAPI_TOKEN"; fi
}
decorate environment


function install_essentials() {
    # May be already completed by cloud-init
    install \
        build-essential \
        coreutils \
        iputils-ping \
        curl wget \
        iptables \
        psmisc \
        zip unzip \
        openssh-client \
        git \
        stow \
        tzdata
}
decorate install_essentials


function set_locale() {
    # May be already completed by cloud-init
    install locales locales-all
    echo "$LANG UTF-8" | sudo tee /etc/locale.gen \
      && sudo locale-gen $LANG \
      && sudo update-locale LANG=$LANG LC_CTYPE=$LANG
}
decorate set_locale


function set_timezone() {
    # May be already completed by cloud-init
    sudo ln -fs /usr/share/zoneinfo/${TIMEZONE} /etc/localtime
    sudo dpkg-reconfigure --frontend noninteractive tzdata
}
decorate set_timezone


function setup_ssh() {
    # May be already completed by cloud-init
    curl -X POST ${DROPBOX_DOWNLOAD_API} \
         --header "Authorization: Bearer ${MYTRAVELAPI_TOKEN}" \
         --header "Dropbox-API-Arg: {\"path\": \"/Documents/travel/id_travel\"}" > ~/.ssh/id_travel
    chmod 400  ~/.ssh/id_travel
    eval $(ssh-agent)
    ssh-add ~/.ssh/id_travel
}
decorate setup_ssh


function prep_code_workspace() {
    mkdir -p $1 ${1}/play ${1}/work ${1}/vendor
    [ -d "${1}/_" ] && echo "_ exists" || git clone https://gitlab-ci-token:${GITLAB_PERSONAL_TOKEN}@gitlab.com/parag_m/knowledge.git ${1}/_
    cd ${1}/_ && git pull origin master && cd -
}
decorate prep_code_workspace


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
    if ! grep -qF "dir_colors" ~/.zshrc; then
        echo "test -r \"~/.dir_colors\" && eval \$(dircolors ~/.dir_colors)" | tee -a ~/.zshrc
    fi
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


function python_stuff() {
    install python3-pip "$@"
    git clone https://github.com/pyenv/pyenv.git ~/.pyenv
    cd ~/.pyenv && src/configure && make -C src
    cd -
    echo "Installing pyenv virtualenv..."
    mkdir -p ~/.pyenv/plugins
    git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
}
decorate python_stuff


function golang_stuff() {
    gopath=$1
    curl -OL "https://go.dev/dl/go${GO_VERSION}.${OS}-${ARCH}.tar.gz"
    sha256sum "go${GO_VERSION}.${OS}-${ARCH}.tar.gz"
    rm -rf ${gopath}/go && tar -C $gopath -xzf "go${GO_VERSION}.${OS}-${ARCH}.tar.gz"
    echo "Go path is set via dotfiles. Path is ${PATH}"
    go version
}
decorate golang_stuff


function rust_stuff() {
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    cargo install cargo-edit
    cargo install cargo-audit
    cargo install cargo-outdated
    rustup component add rustfmt
    rustup component add clippy
}
decorate rust_stuff


function nim_stuff() {
    curl https://nim-lang.org/choosenim/init.sh -sSf | sh
}
decorate nim_stuff


function install_pg_utils() {
    install libpq-dev postgresql-client "$@"
}
decorate install_pg_utils


function install_shell_utils() {
    if [[ -f ~/.zshrc.common ]]; then
        echo "Installing zsh-syntax-highlighting..."
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
            ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

        echo "Installing zsh-autosuggestions..."
        git clone https://github.com/zsh-users/zsh-autosuggestions \
            ${ZSH_CUSTOM}/plugins/zsh-autosuggestions
    fi

    install \
        fzf \
        xclip \
        exa \
        fswatch \
        tree \
        cmatrix
    if [[  ]]
    install fonts-powerline

    # On Gentoo
    # git clone https://github.com/powerline/fonts.git --depth=1
    # # install
    # cd fonts
    # ./install.sh
    # # clean-up a bit
    # cd ..
    # rm -rf fonts
}
decorate install_shell_utils


function install_devtools() {
    install \
        tldr \
        cookiecutter \
        pkg-config automake \
        jq
}
decorate install_devtools


function node_npm_stuff() {
    echo "Installing Volta..."
    curl https://get.volta.sh | bash
    volta install node@lts
    volta list

    echo "Installing Deno..."
    curl -fsSL https://deno.land/x/install/install.sh | sh

    echo "Installing PNPM..."
    curl -f https://get.pnpm.io/v6.16.js | node - add --global pnpm
    pnpm add -g pnpm

    echo "Installing global NPM packages..."
    pnpm add -g @storybook/cli \
         eslint \
         js-beautify \
         prettier \
         import-js \
         http-server \
         typescript typescript-language-server \
         dockerfile-language-server-nodejs \
         bash-language-server \
         @cloudflare/wrangler \
         semver
    pnpm ls -depth=0 -g
}
decorate node_npm_stuff


function ops_stuff() {
    if [[ -x "$(command -v pip)" ]]; then
        pip install --user ansible awscli
    fi

    echo "Installing Hashicorp stuff..."
    curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
    sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
    sudo apt-get update && install nomad terraform packer
    install podman skopeo
    #TODO alias docker

}
decorate ops_stuff


function install_emacs() {
    install emacs-gtk "$@"
}
decorate install_emacs


function dot_emacs() {
    dotfiles=${1}
    mv ~/.emacs.d ~/.emacs.d.backup
    git clone -b develop https://github.com/syl20bnr/spacemacs ~/.emacs.d
    stow -d $dotfiles -vRt ~ emacs
    stow -d $dotfiles -vRt ~/.emacs.d/private emacsd-private-snippets
    stow -d $dotfiles -vRt ~/.emacs.d/private/local emacsd-private-local
    setxkbmap -option 'ctrl:nocaps'
}
decorate dot_emacs


function install_emacs_utils() {
    install x11-xkb-utils
    if [[ -x "$(command -v pip)" ]]; then
        pip install 'python-language-server[all]'
    fi

    install \
        ispell \
        silversearcher-ag
}
decorate install_emacs_utils


function latex_stuff() {
    install texlive-base
    sudo tlmgr update --self
}
decorate latex_stuff


# TODO: use distro check
function setup_spotify() {
    # Assuming debian/ubuntu
    curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | sudo apt-key add -
    echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
    sudo apt-get update && install spotify-client
    git clone https://github.com/hnarayanan/shpotify.git ${1}/shpotify
    chmod +x ${1}/shpotify/spotify
    echo "export PATH=\"${1}/shpotify:$PATH\"" >> ~/.zshrc
}
decorate setup_spotify


function setup_tutorials() {
    curl -L https://git.io/install-rustlings | bash -s ${WORKSPACE_ROOT}/vendor/rustlings
}
decorate setup_tutorials


function security() {
    install signing-party \
            pgpdump \
            keepassxc
}
decorate security

# =====================================
# Execution starts here
# =====================================
#set_password

#environment
#install_essentials
#set_locale
#set_timezone

#setup_ssh

WORKSPACE_ROOT=$HOME/Workspace

prep_code_workspace ${WORKSPACE_ROOT}

clone_dotfiles ${WORKSPACE_ROOT}/play

DOTREPO=${WORKSPACE_ROOT}/play/dotfiles
dot_zsh $DOTREPO
dot_dircolors $DOTREPO
dot_gitconfig $DOTREPO $WORKSPACE_ROOT

python_stuff

GOPATH=${WORKSPACE_ROOT}/vendor/go
golang_stuff $GOPATH

rust_stuff

nim_stuff

install_pg_utils

install_shell_utils

DOTREPO=${WORKSPACE_ROOT}/play/dotfiles
install_emacs
install_emacs_utils
dot_emacs $DOTREPO

setup_spotify

echo "==> Fin"
echo "Run chsh -s /bin/zsh"
