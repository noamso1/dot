# curl https://raw.githubusercontent.com/noamso1/dot/master/setup.sh | bash

set -e ; set -x ; cd ~

sudo apt update -y && sudo apt upgrade -y
sudo apt install -y btop curl git tmux docker.io neovim gcc unzip ripgrep jq rsync cron
curl -fsSL https://deb.nodesource.com/setup_24.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo usermod -aG docker $(whoami)

sudo mv /bin/vi /bin/vi.old
sudo ln -s /bin/nvim /bin/vi

git clone https://github.com/noamso1/dot.git # git clone git@github.com:noamso1/dot.git
cp ~/dot/bashrc ~/.bashrc
cp ~/dot/tmux.conf ~/.tmux.conf
cp ~/dot/nanorc ~/.nanorc
cp ~/dot/gitconfig ~/.gitconfig
cd ~/dot && npm i json5 jsonwebtoken && cd -
rm -rf ~/.config/nvim ~/.local/share/nvim ~/.cache/nvim && mkdir -p ~/.config/nvim && cp -R ~/dot/nvim ~/.config

# ========ufw
# sudo apt install ufw
# sudo ufw allow 22/tcp
# sudo ufw allow 80/tcp
# sudo ufw allow 443/tcp
# sudo ufw allow 3000/tcp
# sudo ufw enable
# sudo ufw status

# ======caddy https ( simple ) ( first connect provider domain to ip )
# ...first point the DNS to the vm's ip
# sudo apt install caddy
# sudo vi /etc/caddy/Caddyfile
# pub.noamso.one {
#   root * /usr/share/caddy
#   file_server
# }
# app.noamso.one {
#   reverse_proxy 127.0.0.1:3000
# }
# sudo systemctl reload caddy
# ======ngnix https ( best performance ) ( first connect provider domain to ip )
# sudo apt install nginx certbot python3-certbot-nginx -y
# sudo certbot --nginx -d mydomain.com
# sudo vi /etc/nginx/sites-available/default
# sudo nginx -t
# sudo systemctl reload nginx

# ====claude
# curl -fsSL https://claude.ai/install.sh | bash

# ====git with dif key
# GIT_SSH_COMMAND='ssh -i ~/.ssh/noamorq -o IdentitiesOnly=yes' git clone git@github.com:noam-orq/orq.git
# git config core.sshCommand 'ssh -i ~/.ssh/noamorq'

# ======graphical
# mkdir -p ~/.local/share/fonts
# cp ~/dot/NotoMonoNerdFontMono-Regular.ttf ~/.local/share/fonts ### IN TERMUX COPY TO ~/.termux/font.ttf
# sudo apt install -y xfce4-panel-profiles fonts-noto-color-emoji chromium gimp audacity transmission remmina libreoffice-calc libreoffice-writer mate-calc blueman
# fc-cache -f
# xfceload

# ======chromium
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

# =======qemu/kvm
# sudo apt install qemu-kvm libvirt-daemon-system libvirt-clients virt-manager
# sudo adduser $USER libvirt
# sudo adduser $USER libvirt-quemu
# sudo adduser $USER kvm
# reboot

