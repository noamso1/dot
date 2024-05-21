sudo apt update -y && sudo apt upgrade -y
sudo apt install -y htop curl git tmux nginx docker.io

git clone https://github.com/noamso1/dot.git
# git clone git@github.com:noamso1/dot.git

cp ~/dot/bashrc ~/.bashrc
cp ~/dot/tmux.conf ~/.tmux.conf
cp ~/dot/nanorc ~/.nanorc

# ==========hstr
sudo add-apt-repository ppa:ultradvorka/ppa
sudo apt-get update
sudo apt-get install hstr

#====================nodejs
installnode #function from .bashrc
sudo npm install -g pm2 mongodb json5
cd ~/dot && npm i json5 && cd -

#=================nvim ===neovim
### install nvim as appimage
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
# check if it works:
./nvim.appimage
  sudo mv ./nvim.appimage /bin
  sudo mv /bin/vi /bin/vi.old
  sudo ln -s /bin/nvim.appimage /bin/vi
# SOMETIMES NEED TO
./nvim.appimage --appimage-extract
./squashfs-root/AppRun --version
sudo mv squashfs-root /
sudo mv /bin/vi /bin/vi.old
sudo ln -s /squashfs-root/AppRun /bin/vi

# my config
apt install -y gcc unzip ripgrep
rm -rf ~/.config/nvim ~/.local/share/nvim ~/.cache/nvim
mkdir -p ~/.config/nvim
tar xf ~/dot/nvim_config.tar.xz -C ~/.config/nvim

#============== NvChad
# rm -rf ~/.config/nvim ~/.local/share/nvim ~/.cache/nvim
# git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
# # comment the 'autopair' section in lua/plugins/init.lua
# # in cmp.lua change CR to C-y

