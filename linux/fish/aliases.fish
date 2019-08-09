# Python
alias spkg='python setup.py sdist bdist_wheel'
alias upkg='twine upload dist/*'
alias env='. .env/bin/activate.fish'

# C++
alias cbuild='sudo g++ -o main main.cpp'
alias crun='./main'

# System
alias update='sudo apt-get update'
alias upgrade='sudo apt-get upgrade'
alias install='sudo apt-get install'
alias remove='sudo apt-get remove'

# utils
alias grantall='sudo chmod -R ugo+rw'
# alias cls="clear && printf '\e[3J'"

# Change location
alias home='cd ~'
alias gallk='cd /mnt/d/gallk/'

alias work='cd /mnt/d/gallk/work/'
alias training='cd /mnt/d/gallk/work/training'
alias web='cd /mnt/d/gallk/work/web'
alias games='cd /mnt/d/gallk/work/games'
alias wind='cd /mnt/d/gallk/work/windows'
alias utils='cd /mnt/d/gallk/work/utils'
