#!/bin/bash

[ -d "/mnt/mydrive" ] && echo "data disk mounted" || $(echo "Please run 'sudo mount -t ntfs /dev/nvme0n1pX /mnt/mydrive"; exit 1)
if [ -z "${MYTRAVELAPI_TOKEN+x}" ]; then echo "Please set MYTRAVELAPI_TOKEN=token" && exit 1; else echo "Using token $MYTRAVELAPI_TOKEN"; fi

echo "===> Set password"
passwd

echo "===> Setting up workspace"
cd /mnt/mydrive
mkdir -p Workspace Workspace/play Workspace/work
cd Workspace
echo "Using $MYTRAVEL_API token"
curl -X POST https://content.dropboxapi.com/2/files/download \
  --header "Authorization: Bearer $MYTRAVELAPI_TOKEN" \
  --header "Dropbox-API-Arg: {\"path\": \"/Documents/travel\"}" > ~/.ssh/id_mydrive
chmod 400  ~/.ssh/id_mydrive
eval $(ssh-agent)
ssh-add ~/.ssh/id_mydrive


echo "===> Downloading git repos"
[ -d "./_" ] && echo "_ exists" || git clone git@gitlab.com:parag_m/knowledge.git _
[ -d "./play/dotfiles" ] && echo "dotfiles exists" || git clone git@gitlab.com:parag_m/dotfiles.git play/dotfiles


echo "===> Set up git config"
ln -s $(pwd)/play/dotfiles/.functions ~/.functions
cp $(pwd)/play/dotfiles/.gitconfig ~/.gitconfig
cp $(pwd)/play/dotfiles/.gitconfig-play ~/.gitconfig-play
cat <<EOF
[includeIf "gitdir:/mnt/mydrive/Workspace/play/"]
        path = "~/.gitconfig-play"
[includeIf "gitdir:/mnt/mydrive/Workspace/_/"]
        path = "~/.gitconfig-play"
[includeIf "gitdir:/mnt/mydrive/Workspace/work/"]
        path = "~/.gitconfig-work"
EOF
cat <<'EOS' > ~/.gitconfig-work
[user]
    name = Parag M.
    email = parag.majumdar@nbt.ag
EOS
ln -s $(pwd)/play/dotfiles/.gitignore_global ~/.gitignore_global
ln -s $(pwd)/play/dotfiles/.gitmessage ~/.gitmessage


echo "==> Tooling setup"
sudo apt install -y tldr
sudo apt install -y python3-pip
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
python3 -m pip install --user cookiecutter
sudo apt install -y jq
sudo apt install -y silversearcher-ag
sudo apt install -y ispell
python3 -m pip install Pygments
sudo apt install -y texlive-latex-base
python3 -m pip install awscli


echo "==> Hashicorp setup"
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install -y terraform nomad vault packer consul


echo "===> Install and setup zsh"
sudo apt install -y zsh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
ln -s $(pwd)/play/dotfiles/.zshrc.common ~/.zshrc.common
ln -s $(pwd)/play/dotfiles/.zshenv.common ~/.zshenv.common
echo "source ~/.zshenv.common" >> ~/.zshenv
echo "export GITLAB_CLI_TOKEN=" >> ~/.zshenv
echo "export GITLAB_USER_PARAG=" >> ~/.zshenv
echo "source \$ZSH/oh-my-zsh.sh" >> ~/.zshrc
echo "source ~/.zshrc.common" >> ~/.zshrc


echo "==> Install password manager"
sudo apt install -y keepassxc


echo "==> Install and setup emacs"
sudo apt install -y emacs-gtk


echo "==> Setup spacemacs"
git clone -b develop https://github.com/syl20bnr/spacemacs ~/.emacs.d
ln -s $(pwd)/play/dotfiles/.spacemacs ~/.spacemacs
rm -rf ~/.emacs.d/private/snippets
ln -s $(pwd)/play/dotfiles/snippets ~/.emacs.d/private/snippets
setxkbmap -option 'ctrl:nocaps'

echo "==> Fin"
echo "Run chsh -s /bin/zsh"
