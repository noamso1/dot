# curl https://raw.githubusercontent.com/noamso1/dot/master/setup.sh | bash

set -e ; set -x ; cd ~

sudo apt update -y && sudo apt upgrade -y
sudo apt install -y htop curl git tmux nginx docker.io neovim nodejs npm gcc unzip ripgrep jq # zoxide
#sudo usermod -aG docker user

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

# # nerdfont
# curl -L https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Ubuntu.zip -o ~/Downloads/nerd.zip ## -L follow redirects
# unzip ~/Downloads/nerd.zip *.ttf -d ~/.local/share/fonts
# fc-cache -f

