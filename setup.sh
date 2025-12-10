# curl https://raw.githubusercontent.com/noamso1/dot/master/setup.sh | bash

set -e ; set -x ; cd ~

sudo apt update -y && sudo apt upgrade -y
sudo apt install -y htop curl git tmux docker.io neovim nodejs npm gcc unzip ripgrep jq rsync cron
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

# ====ngnix with https
# sudo apt install nginx certbot python3-certbot-nginx -y
# sudo certbot --nginx -d mydomain.com
# sudo nginx -t
# sudo systemctl reload nginx

# ===========graphical
# sudo apt install -y chromium gimp audacity transmission remmina libreoffice-calc libreoffice-writer mate-calc blueman

# === nerdfont icons and symbols in terminal
# sudo apt install fonts-noto-color-emoji ### maybe this is enough !!
# curl -L https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Ubuntu.zip -o ~/Downloads/nerd.zip ## -L follow redirects
# unzip ~/Downloads/nerd.zip *.ttf -d ~/.local/share/fonts
# fc-cache -f

# xfceload

# install adblock
# chrome://settings/content/notifications - Don't allow sites to send notifications
# chrome://settings/searchEngines / add /
#   g https://www.google.com/search?q=%s
#   b chrome://bookmarks/?q=%s
#   h chrome://history/?q=%s
#   y https://www.youtube.com/results?search_query=%s
#   m https://www.google.com/maps/search/%s
#   c https://chat.openai.com/?q=%s
#   t https://translate.google.com/?source=osdd&sl=auto&tl=en&text=%s&op=translate
#   z https://www.zap.co.il/search.aspx?keyword=%s

