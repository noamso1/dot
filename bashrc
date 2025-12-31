[[ -z "$PS1" ]] && return # If not running interactively, don't do anything
[[ -z "$TMUX" ]] && [[ -z $(tmux ls 2>&1 | grep attached) ]] && { tmux a || tmux -u ; }

co=${co:-239}
PS1="\[\e[48;5;${co}m\]\u@\h\[\e[48;5;239m\]:\[\e[0m\]\[\e[48;5;56m\]\w\[\e[0m\] "
[[ -n $TMUX ]] && tmux set -g status-style "bg=colour${co} fg=colour137 dim"

EDITOR='vi'
set -o vi #vi key bindings
bind "\C-l":clear-screen
bind "\C-p":previous-history
bind "\C-n":next-history
bind "\C-e":edit-and-execute-command
stty -ixon # disable ctrl-s freeze

# PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r" # After each command, append to the history file and reread it
HISTCONTROL=ignoredups:ignorespace
HISTSIZE=-1
HISTFILESIZE=-1
HISTTIMEFORMAT="%y-%m-%d %T "
shopt -s histappend # append to the history file, don't overwrite it
shopt -s checkwinsize # check the window size after each command and, if necessary, update the values of LINES and COLUMNS.

alias l='ls -ltr --color=auto --time-style="+%Y-%m-%d %H:%M:%S" --group-directories-first --block-size="'"'"'1"'
alias lp='ls -ltrd $PWD/* --color=auto --time-style="+%Y-%m-%d %H:%M:%S" --group-directories-first --block-size="'"'"'1"'
alias ld='l | grep ^d'
alias dirsize='du -sb | cut -f1 | numfmt --grouping'
alias g='egrep -nirs --exclude-dir=node_modules --exclude-dir=.* --color'
alias back='bash ~/misc/back.sh'
alias v='vi ~/misc/linux.txt'
alias t='vi ~/todo.txt'
alias ngi='sudo vi /etc/nginx/conf.d/server.conf'
alias ngs='systemctl restart nginx'
alias ports='sudo lsof -i -P -n | grep LISTEN | grep -E ":[0-9]{2,}" --color'
alias myip='hostname -I; curl ident.me; echo "\n"'
alias hardware='lshw'
alias clip='xclip -selection c' ### ls | clip
alias tm='tmux a || tmux -u' # utf8 support
alias enc='openssl aes-256-cbc -salt -pbkdf2'
alias t1='modprobe -r psmouse'
alias arc='rm -f 1.aaa && tar -c -I "xz -9 -T0" -f 1.tar.xz --exclude=node_modules/* --exclude=*.aaa * && enc -in 1.tar.xz -out 1.aaa -pass pass:1 && rm 1.tar.xz'
alias arcs='f="${PWD}/$(date +"%Y-%m-%d-%H-%M-%S")" && f="${f//\//.}" && f="${f:1}" && tar -c -I "xz -9 -T0" -f ${f}.tar.xz --exclude=node_modules/* --exclude=*.aaa * && enc -in ${f}.tar.xz -out ${f}.aaa -pass pass:1 && rm ${f}.tar.xz && scp -i ~/.ssh/noamso_moovex ${f}.aaa root@142.93.199.90:/root/back && rm ${f}.aaa ;'
alias mongo1='docker run -d -p 27017:27017 -v ~/mongo:/data/db --name mongo1 mongo:latest && docker start mongo1'
alias mongob='docker exec -it mongo1 bash'
alias mongosh='docker exec -it mongo1 mongosh'
alias pg1='docker stop postgres1 ; docker rm postgres1 ; docker run -d --name postgres1 -e POSTGRES_USER=user -e POSTGRES_PASSWORD=1 -e POSTGRES_DB=db1 -p 5432:5432 -v ~/postgres_data:/var/lib/postgresql postgres:latest'
alias pgsh='PGPASSWORD=1 docker exec -it postgres1 psql -U user -d db1'
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
alias wifi_on='nmcli radio wifi on'
alias wifi_off='nmcli radio wifi off'
alias wifi_list='nmcli dev wifi'
alias wifi_connect='nmcli dev wifi connect' # network_nam password password
alias wifi_disconnect='nmcli con down id'
# alias xfcesave='tar cvJf ~/dot/xfce_config.tar.xz -C ~/.config/xfce4/xfconf/xfce-perchannel-xml . && xfce4-panel-profiles save ~/dot/xfce4-panel.tar.gz'
# alias xfceload='tar cfvJ ~/xfce_conf$(date +"%Y-%m-%d-%H-%M-%S").tar.xz ~/.config/xfce4/xfconf/xfce-perchannel-xml/* && tar xvf ~/dot/xfce_config.tar.xz --exclude="displays.xml" -C ~/.config/xfce4/xfconf/xfce-perchannel-xml && pkill xfce4-panel && xfce4-panel-profiles load ~/dot/xfce4-panel.tar.gz && xfce4-panel & '
alias xfcesave='cp ~/.config/xfce4/xfconf/xfce-perchannel-xml/* ~/dot/xfce'
alias xfceload='cp ~/dot/xfce/* ~/.config/xfce4/xfconf/xfce-perchannel-xml && pkill xfce4-panel && xfce4-panel & '
alias st='ssh -i ~/.ssh/noamso_moovex root@142.93.199.90'
alias sm='ssh -i ~/.ssh/maps.cer ubuntu@ssh.maps.moovex.ai'
alias sm2='ssh -i ~/.ssh/maps.cer root@ec2-34-201-173-180.compute-1.amazonaws.com'
alias s2='ssh -i ~/.ssh/noamso4.pem ubuntu@18.233.128.80'
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
alias emojis='for code in {127744..130020}; do printf "\\U$(printf "%08x" $code)"; done; echo'
alias ub1='docker run -ti --rm --name ub1 -v ~/Downloads:/Downloads ubuntu /bin/bash'
alias hh='vi ~/.bash_history'
alias gs='git status'
alias gd='git diff'
alias pacsize='dpkg-query -W --showformat="\${Installed-Size;10}\t\${Package}\n" | sort -k1,1n'
alias node22='~/Downloads/node-v22.9.0-linux-x64/bin/node --experimental-strip-types'
export PL=~/Platform/apps/fleet-backend
export PB=~/Platform/apps/fleet-backend/src/components/routing/core/pb.json
#jwt() { sed 's/\./\n/g' <<< $(cut -d. -f1,2 <<< $1) | base64 --decode | jq ; }
alias jwte='node ~/dot/jwt.js e'
alias jwtd='node ~/dot/jwt.js d'
engine() { export DEBUG_ENGINE=true && export TS_NODE_COMPILER_OPTIONS='{"lib":["esnext","dom"]}' && cd ~/moovex_development/moovex_new_server && npx ts-node ./src/components/routing/core/engine.ts "test$1" ; }
c() { export BC_LINE_LENGTH=0; echo "scale=3; $*" | bc; } #calculator
encr() { echo $1 | openssl aes-256-cbc -salt -pbkdf2 -a -pass pass:$2 ; }
decr() { echo $1 | openssl aes-256-cbc -salt -pbkdf2 -a -d ; }
encrf() { openssl aes-256-cbc -salt -pbkdf2 -in "$1" -out "$2" -pass pass:$3 ; }
decrf() { openssl aes-256-cbc -salt -pbkdf2 -in "$1" -out "$2" -d ; }
tarenc() { [ -z "$3" ] && echo "usage: tarenc in.txt more.* out.aaa pass" || tar cvJ "${@:1:$#-2}" | openssl aes-256-cbc -salt -pbkdf2 -pass pass:${@: -1} -out "${@: -2:1}" ; }
tardec() { [ -z "$2" ] && echo "usage: tardec file.aaa pass" || openssl aes-256-cbc -salt -pbkdf2 -in "${1}" -pass pass:${2} -d | tar xJ ; }
tarenct() { [ -z "$3" ] && echo "usage: tarenct in.txt more.* out.txt pass" || tar cvJ "${@:1:$#-2}" | openssl aes-256-cbc -salt -pbkdf2 -pass pass:${@: -1} -a -out "${@: -2:1}" ; } ### tar and encrypt to text
tardect() { [ -z "$2" ] && echo "usage: tardect file.txt pass" || openssl aes-256-cbc -salt -pbkdf2 -in "${1}" -pass pass:${2} -a -d | tar xJ ; } # tardec file pass
tarexc() { tar cvJf "${1:-1.tar.xz}" --exclude='.[^/]*' --exclude=node_modules "${2:-*}" ; }
gitpush() { git add --all && git commit -a -m "${1:-.}" && git push ; }
gitfeature() { git checkout -b "${1}" ; git add --all ; git commit -m "${1}" ; git push -u origin $1 ; }

