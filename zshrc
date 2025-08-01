
### SETTINGS ###
# filevault
# hide dock
# input languages
# fast user switch
# keyboard brightness in menu bar
# disable force click
# zoom - use scroll gesture

# mkdir homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C homebrew

# curl -L https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/UbuntuMono.zip -o ~/Downloads/nerd.zip
# cd ~/Downloads && unzip nerd.zip

# GIT_SSH_COMMAND='ssh -i ~/.ssh/noamso_moovex -o IdentitiesOnly=yes' git clone git@github.com:Moovex/moovex_server.git
# git config core.sshCommand 'ssh -i ~/.ssh/noamso_moovex'

# GIT_SSH_COMMAND='ssh -i ~/.ssh/noam_mc1_rsa -o IdentitiesOnly=yes' git clone git@ssh.dev.azure.com:v3/MC1Projects/WTM%20IRS/ire-dashboard
# git config core.sshCommand 'ssh -i ~/.ssh/noam_mc1_rsa'

# brew install --cask google-cloud-sdk

umask 0077
export PATH="/Users/${USER}/homebrew/bin:$PATH"

[[ -z "$PS1" ]] && return # If not running interactively, don't do anything
[[ -z "$TMUX" ]] && [[ -z $(tmux ls 2>&1 | grep attached) ]] && { tmux a || tmux -u ; }
[[ -n $TMUX ]] && tmux set -g status-style "bg=colour2 fg=colour137 dim"

export PS1="%F{yellow}%n %F{cyan}%~ %F{white}> "

EDITOR='nvim'
set -o vi

setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS
HISTSIZE=10000000
SAVEHIST=10000000

bindkey '^P' history-search-backward
bindkey '^N' history-search-forward
bindkey '^R' history-incremental-search-backward

alias vi='nvim'
alias l='ls -ltr'
alias ld='l | grep ^d'
alias g='egrep -nirs --exclude-dir=node_modules --exclude-dir=.* --color'
alias back='bash ~/misc/back.sh'
alias v='vi ~/misc/linux.txt'
alias t='vi ~/todo.txt'
alias ngi='sudo vi /etc/nginx/conf.d/server.conf'
alias ngs='systemctl restart nginx'
alias ports='sudo lsof -i -P -n | grep LISTEN | grep -E ":[0-9]{2,}" --color'
alias myip='hostname -I; curl ident.me; echo "\n"'
alias hardware='lshw'
alias tm='tmux a || tmux -u' # utf8 support
alias enc='openssl aes-256-cbc -salt -pbkdf2'
alias t1='modprobe -r psmouse'
alias archive1='tar -c -I "xz -9 -T0" -f 1.tar.xz --exclude=node_modules/* * && enc -in 1.tar.xz -out 1.aaa -pass pass:1 && rm 1.tar.xz'
alias mongo1='docker run -p 27017:27017 -v ~/mongo:/data/db --name mongo1 mongo'
alias mongob='docker exec -it mongo1 bash'
alias mongosh='docker exec -it mongo1 mongosh'
alias redis1='docker run --name redis1 -p 6379:6379 -d redis'
alias dockerkill1='docker rm -f $(docker ps -aq)'
alias dockerkill2='docker rm -f $(docker ps -aq) ; docker volume rm $( docker volume ls -q )'
alias dockerkill3='docker rm -f $(docker ps -aq) ; docker volume rm $( docker volume ls -q ) ; docker rmi $(docker images -q)'
alias pj='node ~/dot/json5parser.js'
#alias d='echo $(date +"%Y-%m-%d %H:%M:%S")'
alias d='node ~/dot/d.js'
alias vil='vi -u NONE -c "set nowrap"' #open large log files without extentions
alias nvimsave='cp -R ~/.config/nvim ~/dot'
alias nvimload='cp -R ~/dot/nvim ~/.config'

alias st='ssh -i ~/.ssh/maps.cer root@test.moovex.com'
alias sm='ssh -i ~/.ssh/maps.cer ubuntu@ssh.maps.moovex.ai'
alias s2='ssh -i ~/.ssh/noamso4.pem ubuntu@18.233.128.80'
alias sn='ssh root@noamso.one'
alias sg='gcloud cloud-shell ssh --authorize-session'
alias vnctunnel='ssh -L 5901:localhost:5901 -N -C root@noamso.one'
alias toascii='od -An -vtu1' #hex
alias curlt='curl -w "\nTIME %{time_total}\n"'
alias up='sudo apt update -y && sudo apt upgrade -y'
alias ampy='/home/noam/.local/bin/ampy --port /dev/ttyACM0'
alias gcp='gcloud config get-value project'
alias gcpp='gcloud config set project'
alias bqq='bq query --nouse_legacy_sql --max_rows=1000'
alias bqq2='bq query --nouse_legacy_sql --max_rows=100000'
alias bqqcsv='bq query --nouse_legacy_sql --max_rows=100000 --format=csv'
alias bqqjson='bq query --nouse_legacy_sql --max_rows=100000 --format=json'
alias gcplog='gcloud functions logs read --limit=500 --sort-by=TIME_UTC'
alias colors='for i in {0..255}; do printf "\x1b[38;5;${i}mcolor%-5i\x1b[0m" $i ; if ! (( ($i + 1 ) % 8 )); then echo ; fi ; done'
alias ub1='docker run -ti --rm --name ub1 -v ~/Downloads:/Downloads ubuntu /bin/bash'
alias hh='vi ~/.zsh_history'
alias gs='git status'
alias gd='git diff'
alias gitreset='git fetch origin && git reset --hard origin/$(git rev-parse --abbrev-ref HEAD) && git clean -fd'
alias pacsize='dpkg-query -W --showformat="\${Installed-Size;10}\t\${Package}\n" | sort -k1,1n'
alias node22='~/Downloads/node-v22.9.0-linux-x64/bin/node --experimental-strip-types'
# alias mo1='sudo xhost +SI:localuser:mo && sudo su mo' #grant mo access to display and clipboard, and switch to mo user
# alias mo0='xhost -SI:localuser:mo' # disable display access for mo

c() { export BC_LINE_LENGTH=0; echo "scale=3; $*" | bc; } #calculator
encr() { echo $1 | openssl aes-256-cbc -salt -pbkdf2 -a -pass pass:$2 ; }
decr() { echo $1 | openssl aes-256-cbc -salt -pbkdf2 -a -d ; }
encrf() { [ -z "$3" ] && echo "usage: encrf in.txt out.txt pass" || openssl aes-256-cbc -salt -pbkdf2 -in "$1" -out "$2" -pass pass:$3 ; }
decrf() { [ -z "$2" ] && echo "usage: decrf in.txt out.txt" || openssl aes-256-cbc -salt -pbkdf2 -in "$1" -out "$2" -d ; }
tarenc() { [ -z "$3" ] && echo "usage: tarenc in.txt more.* out.aaa pass" || tar cvJ "${@[1,-3]}" | openssl aes-256-cbc -salt -pbkdf2 -pass pass:${@[-1]} -out "${@[-2]}" ; }
tardec() { [ -z "$2" ] && echo "usage: tardec file.aaa pass" || openssl aes-256-cbc -salt -pbkdf2 -in "${1}" -pass pass:${2} -d | tar xJ ; }
tarenct() { [ -z "$3" ] && echo "usage: tarenct in.txt more.* out.txt pass" || tar cvJ "${@[1,-3]}" | openssl aes-256-cbc -salt -pbkdf2 -pass pass:${@[-1]} -a -out "${@[-2]}" ; } ### tar and encrypt to text
tardect() { [ -z "$2" ] && echo "usage: tardect file.txt pass" || openssl aes-256-cbc -salt -pbkdf2 -in "${1}" -pass pass:${2} -a -d | tar xJ ; }
tarexc() { tar cvJf "${1:-1.tar.xz}" --exclude='.[^/]*' --exclude=node_modules "${2:-*}" ; }
jwt() { sed 's/\./\n/g' <<< $(cut -d. -f1,2 <<< $1) | base64 --decode | jq ; }
gitpush() { git add --all ; git commit -a -m "${1:-.}" ; git push ; }
gitfeature() { git checkout -b "${1}" ; git add --all ; git commit -m "${1}" ; git push -u origin $1 ; }


