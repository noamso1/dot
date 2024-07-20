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
alias archive1='tar -c -I "xz -9 -T0" -f 1.tar.xz --exclude=node_modules/* * && enc -in 1.tar.xz -out 1.aaa -pass pass:1 && rm 1.tar.xz'
alias mongo1='docker run -d -p 27017:27017 -v ~/mongo:/data/db --name mongo1 mongo:latest && docker start mongo1'
alias mongob='docker exec -it mongo1 bash'
alias mongo='docker exec -it mongo1 mongosh' # "mongodb+srv://kiki:XXXXXXXX@moovexprodcluster.au6ui.mongodb.net"
alias redis1='docker run --name redis1 -p 6379:6379 -d redis'
alias dockerkill='docker rm -f $(docker ps -aq) ; # docker volume rm $( docker volume ls -q ) ; docker rmi $(docker images -q)'
alias pj='node ~/dot/json5parser.js'
#alias d='echo $(date +"%Y-%m-%d %H:%M:%S")'
alias d='node ~/dot/d.js'
alias vil='vi -u NONE -c "set nowrap"' #open large log files without extentions
alias nvimsave='tar cvJf ~/dot/nvim_config.tar.xz --exclude='.[^/]*' -C ~/.config/nvim .'
alias nvimload='tar xf ~/dot/nvim_config.tar.xz -C ~/.config/nvim'
alias st='ssh -i ~/.ssh/maps.cer root@test.moovex.com'
alias sm='ssh -i ~/.ssh/maps.cer ubuntu@ssh.maps.moovex.ai'
alias sa='ssh -i ~/.ssh/maps.cer ubuntu@ssh.node.moovex.com'
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
alias hh='vi ~/.bash_history'
alias gs='git status'
alias gd='git diff'

c() { export BC_LINE_LENGTH=0; echo "scale=3; $*" | bc; } #calculator
encr() { echo $1 | openssl aes-256-cbc -salt -pbkdf2 -a -pass pass:$2 ; }
decr() { echo $1 | openssl aes-256-cbc -salt -pbkdf2 -a -d ; }
encrf() { openssl aes-256-cbc -salt -pbkdf2 -in $1 -out $2 -pass pass:$3 ; }
decrf() { openssl aes-256-cbc -salt -pbkdf2 -in $1 -out $2 -d ; }
tarenc() { tar cvJ ${@:1:$#-2} | openssl aes-256-cbc -salt -pbkdf2 -pass pass:${@: -1} -out ${@: -2:1} ; } ### tar and encrypt ### tarenc infile.txt moreinfiles.* outfile pass
tardec() { openssl aes-256-cbc -salt -pbkdf2 -in ${1} -pass pass:${2} -d | tar xJ ; } ### tardec file pass
tarenct() { tar cvJ ${@:1:$#-2} | openssl aes-256-cbc -salt -pbkdf2 -pass pass:${@: -1} -a -out ${@: -2:1} ; } ### tar and encrypt to text ### tarenc infile.txt moreinfiles.* outfile pass
tardect() { openssl aes-256-cbc -salt -pbkdf2 -in ${1} -pass pass:${2} -a -d | tar xJ ; } # tardec file pass
tarex() { tar cvJf ${1:-1.tar.xz} --exclude='.[^/]*' --exclude=node_modules ${2:-*} ; }
jwt() { sed 's/\./\n/g' <<< $(cut -d. -f1,2 <<< $1) | base64 --decode | jq ; }
gitpush() { git add --all ; git commit -a -m "${1:-.}" ; git pull ; git push ; }
gitfeature() { git checkout -b "${1}" ; git add --all ; git commit -m "${1}" ; git push -u origin $1 ; }

installnode() {
  sudo apt-get update
  sudo apt-get install -y ca-certificates curl gnupg
  sudo mkdir -p /etc/apt/keyrings
  curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
  echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_${1:-20}.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
  sudo apt-get update
  sudo apt-get install nodejs -y
  node -v
  sudo npm i -g pm2
}

