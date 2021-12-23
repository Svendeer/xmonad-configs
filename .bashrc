
bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'
set completion-ignore-case on

git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

#PS1="\[\033[0;31m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\033[0;31m\]]\342\224\200\")[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]root\[\033[01;33m\]'; else echo '\[\e[1;34m\] \[\e[0m\]\[\e[1;34m\]\u'; fi)\[\033[0;31m\]]\342\224\200[\[\033[1;32m\] \w \$(git_status)\[\033[0;31m\]] \[\033[1;36m\]\n\[\033[1;31m\]\342\224\224\342\224\200\342\224\200\342\225\274\[\033[0m\]\[\e[1;33m\] \[\e[1;37m\]"
#PS1+="${GITSTATUS_PROMPT:+ $GITSTATUS_PROMPT}"

if [ "$PS1" ]; then
    complete -cf sudo
fi

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

lastLogin(){
    echo "Last login: $(last -1 -R  $USER | head -1 | cut -c 20- | xargs)"
}

#Black: 30
#Blue: 34
#Cyan: 36
#Green: 32
#Purple: 35
#Red: 31
#White: 37
#Yellow: 33


# this is for the git status on my bash prompt

PS1="\[\033[1;36m\] vanDerSaar :\[\033[0;1;33;32m\]: \w\[\033[0;1;33;34m\] \$(git_branch)\\n\[\033[1;91m\][] \[\e[0;37;49m\]"

#PS1='\[\e[1;33m\]\[\e[26;1;43;49m\]\[\e[33;1;15;44;1;215m\]\[\e[30\]\[\e[43;30;1;215m   \[\e[34;0;15;42;1;215m\]\[\e[30\]\[\e[43;30;1;215m \w \[\e[49m\]\[\e[33;1;43;49m\]\[\033[1;49;96m\]\n\[\e[1;31;49m\] \[\e[1;37;49m\]'
#PS1="\[\033[1;36m\]  \u\[\033[1;93m\]::\[\033[1;32m\]  \w\[\033[1;49;96m\] \$(git_branch)\\n\[\033[1;91m\]> \[\e[0;37;49m\]"

#PS1="\[\033[3;92m\]\w\[\033[0;1;33;93m\] \$(git_branch)\\n\[\033[1;91m\]> \[\e[0;37;49m\]"

#PS1="\n\[\e[0;38;5;118m\]┏━━━━┫\[\e[1;48;5;118;1;38;5;16m\] \u@\h \[\e[0;38;5;118m\]┣━━┫\[\e[1;48;5;118;1;38;5;16m\] \W \[\e[0;38;5;118m\]┣━━━━━\n┃\n┗━━\$❱\[\e[0m\] "
#PS1='\[\e[1;34m\]\[\e[94;1;44;49m\] \[\e[1;34m\]\[\e[101;1;15;101;1;215m\]\[\e[30\]\[\e[104;97;1;215m \u \[\e[49m\]\[\e[34;1;44;49m\]\[\e[32;1;42;49m\]\[\e[32;1;15;42;1;215m\]\[\e[30\]\[\e[42;30;1;215m \w \[\e[49m\]\[\e[32;1;42;49m\]\[\033[1;49;96m\]\n\[\e[1;31;42;49m\] \[\e[1;41;31;215;49m\]\[\e[101;1;101;97m\]  \[\e[1;31;31;49m\] \[\e[1;37;49m\]'

#PS1="\[\e[2;33m\](  \[\e[2;32m\]\u: \w) \n\[\e[2;31m\]\[\e[2;37m\]" 

#shopt -s checkwinsize
#
#function prompt_right() {
#    echo -e "\e[34;1;43;49m \]\[\e[34;1;15;43;1;215m\]\$([[ \$? != 0 ]] && echo \"\[\e[34\]\[\e[44;31;1;215m  \")\[\e[30\]\[\e[44;30;1;215m $(date +'%I:%M') \]\[\e[34;1;42;49m\] " #  
#}
#
#function prompt_left() {
#  echo -e "\[\e[1;34m\]\[\e[33;1;43;49m\] \[\e[33;1;15;43;1;215m\]\[\e[30\]\[\e[43;30;1;215m   \[\e[32;1;15;42;1;215m\]\[\e[30\]\[\e[42;30;1;215m \w \[\e[49m\]\[\e[32;1;42;49m\]\[\033[1;49;96m\]\[\e[34;1;15;42;1;215m\]\[\e[30\]\[\e[44;37;1;215;49m\$(git_branch) \n\[\e[1;31;49m\] \[\e[1;37;49m\]"
#}
#
#function prompt() {
#    compensate=140
#    PS1=$(printf "%*s\r%s " "$(($(tput cols)+${compensate}))" "$(prompt_right)" "$(prompt_left)")
#}
#PROMPT_COMMAND=prompt

# Alias
alias s="sudo"
alias p="pacman"
alias n="nvim"
alias l="ls -la"
alias la="ls -la"
alias dk="cd ~/Escritorio"
alias doc="cd ~/Documentos"
alias vd="cd ~/Vídeos"
alias dw="cd ~/Descargas"
alias pic="cd ~/Imágenes"
alias nv="nvim ~/.config/nvim/init.vim"
alias qtc="nvim ~/.config/qtile/config.py"
alias qtf="cd ~/.config/qtile"
alias gt="cd ~/GitHub"
alias mv="mv -v"
alias t="tmux -u"
alias cf="cd ~/.config"
alias sp="sudo pacman"
alias py="python3"
alias cl="clear"
alias sc="source"
alias ra="ranger"
alias x="exit"
alias pof="poweroff"
alias jc="javac"
alias ja="java"
alias ..="cd .."
alias rm="rm -rfv"
alias sysc="systemctl"
alias ssys="sudo systemctl"
alias ydl="youtube-dl"
alias mkdir="mkdir -v"
alias vim="nvim"

# Git alias
alias gc="git clone"
alias gm="git commit -m"
alias gl="git log"
alias ga="git add"
alias gs="git status"
alias gr="git rm"
alias gb="git branch"
alias gp="git pull"
alias gch="git checkout"
alias cp="cp -rvf"
alias aoeu="localectl set-x11-keymap dvorak es"
alias asdf="localectl set-x11-keymap es"
alias extar="tar -xzvf"
alias comptar="tar -czvf"
alias rb="reboot"
alias importkey="sudo gpg --recv-keys"
alias df="pydf"
alias c0de="cd ~/Documentos/c0de/"
alias haskell="cd ~/Documentos/c0de/haskell"
alias paiton="cd ~/Documentos/c0de/Python"
alias c++="cd ~/Documentos/c0de/cpp"
alias c="clear"

#echo -e -n "\x1b[\x30 q" # changes to blinking block
#echo -e -n "\x1b[\x31 q" # changes to blinking block also
#echo -e -n "\x1b[\x32 q" # changes to steady block
echo -e -n "\x1b[\x33 q" # changes to blinking underline
echo -e -n "\x1b[\x34 q" # changes to steady underline
#echo -e -n "\x1b[\x35 q" # changes to blinking bar
#echo -e -n "\x1b[\x36 q" # changes to steady bar

alias colortest="npx colortest"
