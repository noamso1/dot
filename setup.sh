
sudo apt update y && sudo apt upgrade -y
sudo apt install -y htop curl git tmux nginx docker.io
sudo npm install -g pm2 mongodb 

git clone git@github.com:noamso1/dot.git
cp ~/dot/bashrc ~/.bashrc
cp ~/dot/tmux.conf ~/.tmux.conf
cp ~/dot/nanorc ~/.nanorc.conf

#====================nodejs
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
NODE_MAJOR=18
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
sudo apt-get update
sudo apt-get install nodejs -y
node -v

#=================nvim ===neovim
### install nvim as appimage
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage ## check if it works
sudo mv ./nvim.appimage /bin
sudo mv /bin/vi /bin/vi.old
sudo ln -s /bin/nvim.appimage /bin/vi

### SOMETIMES NEED TO
./nvim.appimage --appimage-extract
./squashfs-root/AppRun --version
sudo mv squashfs-root /
sudo mv /bin/vi /bin/vi.old
sudo ln -s /squashfs-root/AppRun /bin/vi

### my config
apt install nodejs npm gcc unzip ripgrep
mkdir -p ~/.config/nvim
rm -rf ~/.config/nvim ~/.local/share/nvim ~/.cache/nvim
tar xf ~/dot/nvim_config.tar.xz -C ~/.config/nvim

### NvChad
rm -rf ~/.config/nvim ~/.local/share/nvim ~/.cache/nvim
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
# comment the 'autopair' section in lua/plugins/init.lua
# in cmp.lua change CR to C-y

