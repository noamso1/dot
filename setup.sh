# curl https://raw.githubusercontent.com/noamso1/dot/master/setup.sh | bash

set -e ; set -x ; cd ~

sudo apt update -y && sudo apt upgrade -y
sudo apt install -y htop curl git tmux docker.io neovim nodejs npm gcc unzip ripgrep jq chromium
sudo usermod -aG docker $(whoami)

sudo mv /bin/vi /bin/vi.old
sudo ln -s /bin/nvim /bin/vi

git clone https://github.com/noamso1/dot.git # git clone git@github.com:noamso1/dot.git
cp ~/dot/bashrc ~/.bashrc
cp ~/dot/tmux.conf ~/.tmux.conf
cp ~/dot/nanorc ~/.nanorc
cp ~/dot/gitconfig ~/.gitconfig
cd ~/dot && npm i json5 && cd -
rm -rf ~/.config/nvim ~/.local/share/nvim ~/.cache/nvim && mkdir -p ~/.config/nvim && cp -R ~/dot/nvim ~/.config

# === nerdfont icons and symbols in terminal
# curl -L https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Ubuntu.zip -o ~/Downloads/nerd.zip ## -L follow redirects
# unzip ~/Downloads/nerd.zip *.ttf -d ~/.local/share/fonts
# fc-cache -f

# xfceload

# install adblock
# chrome://settings/content/notifications - Don't allow sites to send notifications
# chrome://settings/searchEngines / add /
#   b chrome://bookmarks/?q=%s
#   h chrome://history/?q=%s
#   y https://www.youtube.com/results?search_query=%s
#   m https://www.google.com/maps/search/%s
#   c https://chat.openai.com/?q=%s
#   t https://translate.google.com/?source=osdd&sl=auto&tl=en&text=%s&op=translate
#   z https://www.zap.co.il/search.aspx?keyword=%s
