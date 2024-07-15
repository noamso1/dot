# curl https://raw.githubusercontent.com/noamso1/dot/master/setup.sh | bash

set -e ; set -x ; cd ~

sudo apt update -y && sudo apt upgrade -y
sudo apt install -y htop curl git tmux nginx docker.io neovim nodejs npm gcc unzip ripgrep jq

sudo mv /bin/vi /bin/vi.old
sudo ln -s /bin/nvim /bin/vi

git clone https://github.com/noamso1/dot.git # git clone git@github.com:noamso1/dot.git
cp ~/dot/bashrc ~/.bashrc
cp ~/dot/tmux.conf ~/.tmux.conf
cp ~/dot/nanorc ~/.nanorc
cp ~/dot/gitconfig ~/.gitconfig

sudo npm install -g pm2 mongodb
cd ~/dot && npm i json5 && cd -

rm -rf ~/.config/nvim ~/.local/share/nvim ~/.cache/nvim
mkdir -p ~/.config/nvim
tar xf ~/dot/nvim_config.tar.xz -C ~/.config/nvim
