# If not running interactively, don't do anything
[ -z "$PS1" ] && return
[[ -z "$TMUX" ]] && [[ -z $(tmux ls 2>&1 | grep attached) ]] && { tmux a || tmux -u ; }

set -o vi #vi key bindings
EDITOR='vi'

# PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r" # After each command, append to the history file and reread it
HISTCONTROL=ignoredups:ignorespace
HISTSIZE=-1
HISTFILESIZE=-1
HISTTIMEFORMAT="%y-%m-%d %T "
shopt -s histappend # append to the history file, don't overwrite it
shopt -s checkwinsize # check the window size after each command and, if necessary, update the values of LINES and COLUMNS.

# HSTR
export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"
export HSTR_TIOCSTI=y
export HSTR_CONFIG=prompt-bottom,hicolor,no-confirm,raw-history-view
# if [[ $- =~ .*i.* ]]; then bind '"\C-r": "\C-a hstr -- \C-j"'; fi # normal mode
if [[ $- =~ .*i.* ]]; then bind '"\C-r": "\e0ihstr -- \n"'; fi # vi key bindings mode

bind "\C-l":clear-screen
bind "\C-p":previous-history
bind "\C-n":next-history

# 1;32m green 1;31m red 1;33m yellow 1;95m purple 1;36m cyan
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;95m\]\w\[\033[00m\] '

PS1='\[\e[48;5;239m\]\u@\h:\w\[\e[0m\] ' ; [[ -n $TMUX ]] && tmux set -g status-style 'bg=colour239 fg=colour137 dim' ;
[[ $HOSTNAME = noam2 ]]           && { PS1='\[\e[48;5;2m\]\u@\h\[\e[48;5;239m\]:\[\e[0m\]\[\e[48;5;56m\]\w\[\e[0m\] ' ; [[ -n $TMUX ]] && tmux set -g status-style 'bg=colour2 fg=colour137 dim' ; } #local
[[ $HOSTNAME = noam ]]            && { PS1='\[\e[48;5;3m\]\u@\h\[\e[48;5;239m\]:\[\e[0m\]\[\e[48;5;56m\]\w\[\e[0m\] ' ; [[ -n $TMUX ]] && tmux set -g status-style 'bg=colour3 fg=colour137 dim' ; } #noamso
[[ $HOSTNAME = osrm1 ]]           && { PS1='\[\e[48;5;6m\]\u@\h\[\e[48;5;239m\]:\[\e[0m\]\[\e[48;5;56m\]\w\[\e[0m\] ' ; [[ -n $TMUX ]] && tmux set -g status-style 'bg=colour14 fg=colour137 dim' ; } #test
[[ $HOSTNAME = ip-172-31-82-23 ]] && { PS1='\[\e[48;5;1m\]\u@\h\[\e[48;5;239m\]:\[\e[0m\]\[\e[48;5;56m\]\w\[\e[0m\] ' ; [[ -n $TMUX ]] && tmux set -g status-style 'bg=colour1 fg=colour137 dim' ; } #prod
[[ $HOSTNAME = ip-172-31-85-22 ]] && { PS1='\[\e[48;5;5m\]\u@\h\[\e[48;5;239m\]:\[\e[0m\]\[\e[48;5;56m\]\w\[\e[0m\] ' ; [[ -n $TMUX ]] && tmux set -g status-style 'bg=colour5 fg=colour137 dim' ; } #maps
[[ $HOSTNAME = cs-1014835612471-default ]] && { PS1='\[\e[48;5;130m\]\u@\h[\e[48;5;239m\]:\[\e[0m\]\[\e[48;5;56m\]\w\[\e[0m\] ' ; [[ -n $TMUX ]] && tmux set -g status-style 'bg=colour130 fg=colour137 dim' ; } #gcpmc1

alias l='ls -ltr --color=auto --time-style="+%Y-%m-%d %H:%M:%S" --group-directories-first --block-size="'"'"'1"'
alias lp='ls -ltrd $PWD/* --color=auto --time-style="+%Y-%m-%d %H:%M:%S" --group-directories-first --block-size="'"'"'1"'
alias ld='l | grep ^d'
alias g='egrep -nir --exclude-dir=node_modules --exclude-dir=.* --color'
alias back='node ~/misc/back.js'
alias v='vi ~/misc/linux.txt'
alias t='vi ~/todo.txt'
alias ngi='sudo vi /etc/nginx/conf.d/server.conf'
alias ngs='systemctl restart nginx'
alias ports='sudo lsof -i -P -n | grep LISTEN | grep -E ":[0-9]{2,}" --color'
alias myip='hostname -I; curl ident.me; echo "\n"'
alias hardware='lshw'
#alias clip='xclip -selection c' ### ls | clip
alias tm='tmux a || tmux -u' # utf8 support
alias enc='openssl aes-256-cbc -salt -pbkdf2'
alias t0='synclient TouchpadOff=1'
alias t1='synclient TouchpadOff=0 && syndaemon -i 0.4 -K -t -d'
alias t2='sudo apt purge xserver-xorg-input-synaptics -y && sudo apt autoremove && sudo apt install xserver-xorg-input-synaptics'
alias archive1='tar -c -I "xz -9 -T0" -f 1.tar.xz --exclude=node_modules/* * && enc -in 1.tar.xz -out 1.aaa -pass pass:1 && rm 1.tar.xz'
alias mongo1='sudo docker run -d -p 27017:27017 -v ~/mongo:/data/db --name mongo1 mongo:latest && sudo docker start mongo1'
alias mongob='sudo docker exec -it mongo1 bash'
alias mongo='sudo docker exec -it mongo1 mongosh' # "mongodb+srv://kiki:XXXXXXXX@moovexprodcluster.au6ui.mongodb.net"
alias redis1='sudo docker run --name redis1 -p 6379:6379 -d redis'
alias dockerkill='sudo docker rm -f $(sudo docker ps -aq)'
alias pj='node ~/dot/json5parser.js'
alias d='node ~/dot/d.js'
#alias d='echo $(date +"%Y-%m-%d %H:%M:%S")'
alias vil='vi -u NONE -c "set nowrap"' #open large log files without extentions
alias nvimsave='tar cvJf ~/dot/nvim_config.tar.xz --exclude='.[^/]*' -C ~/.config/nvim .'
alias nvimload='tar xf ~/dot/nvim_config.tar.xz -C ~/.config/nvim'
alias st='ssh -i ~/.ssh/maps.cer root@test.moovex.com'
alias sm='ssh -i ~/.ssh/maps.cer ubuntu@ssh.maps.moovex.ai'
alias sa='ssh -i ~/.ssh/maps.cer ubuntu@ssh.node.moovex.com'
alias s2='ssh -i ~/.ssh/noamso4.pem ubuntu@ec2-18-234-209-247.compute-1.amazonaws.com'
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
alias ub1='sudo docker run -ti --rm --name ub1 -v ~/Downloads:/Downloads ubuntu /bin/bash'
alias hh='vi ~/.bash_history'
c() { export BC_LINE_LENGTH=0; echo "scale=3; $1" | bc; } #calculator
encr() { echo $1 | openssl aes-256-cbc -salt -pbkdf2 -a -pass pass:$2 ; }
decr() { echo $1 | openssl aes-256-cbc -salt -pbkdf2 -a -d ; }
encrf() { openssl aes-256-cbc -salt -pbkdf2 -in $1 -out $2 -pass pass:$3 ; }
decrf() { openssl aes-256-cbc -salt -pbkdf2 -in $1 -out $2 -d ; }
jwt() { sed 's/\./\n/g' <<< $(cut -d. -f1,2 <<< $1) | base64 --decode | jq ; }
gitpush() { git add --all ; git commit -a -m "${1:-.}" ; git pull ; git push ; }
gitfeature() { git checkout -b "${1}" ; git add --all ; git commit -m "${1}" ; git push -u origin $1 ; }
tarex() { tar cvJf ${1:-1.tar.xz} --exclude='.[^/]*' --exclude=node_modules ${2:-*} ; }
installnode() {
  sudo apt-get update
  sudo apt-get install -y ca-certificates curl gnupg
  sudo mkdir -p /etc/apt/keyrings
  curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
  echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_${1:-18}.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
  sudo apt-get update
  sudo apt-get install nodejs -y
  node -v
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

# git clone --recursive --depth 1 --shallow-submodules https://github.com/akinomyoga/ble.sh.git
# make -C ble.sh
# source ble.sh/out/ble.sh
alias ble='source ~/ble.sh/out/ble.sh'

[ -f $HOME/.bashrcadd ] && . $HOME/.bashrcadd

