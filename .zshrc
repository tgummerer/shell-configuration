ZSH=~/lib/oh-my-zsh

export TERM=xterm-256color
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export PERL5LIB=~/share/perl5/site_perl/

export ZSH_THEME="tgummerer"

PATH=/opt/android-sdk/tools/:/opt/android-sdk/platform-tools/:/home/tommy/.gem/ruby/2.0.0/bin:~/dev/exports64/drmemory/bin64/:~/.cabal/bin/:~/.bin/:/sw/bin:/opt/local/bin:~/Applications/android-sdk-mac_x86/platform-tools:~/Applications/android-ndk-r6b:$PATH

alias t='python ~/lib/shell-configuration/tools/t/t.py --task-dir ~/tasks --list tasks'

alias f='find . | grep'
alias fx='find . -type f | xargs grep'

alias g='git'
alias gl='git log --oneline --graph --decorate --all'
alias gs='git status -s'
alias gc='git commit'
alias gcp='git commit -pv'
alias gm='git commit -m'
alias ga='git add -A -p'
alias gg='git grep'
alias grc='git rebase --continue'

alias m="make -j6"
alias m0="make -j6 O=0"
alias mt="make -j6 test"
alias mt0="make -j6 O=0 test"

alias sd="python manage.py syncdb"
alias rs="python manage.py runserver"

alias 0="amixer set Master 0%"
alias 15="amixer set Master 15%"
alias 25="amixer set Master 25%"
alias 50="amixer set Master 50%"
alias 75="amixer set Master 75%"
alias 100="amixer set Master 100%"

alias e="emacsclient -c &"
alias et="emacsclient -t"

export EDITOR="emacsclient -t"

DISABLE_AUTO_UPDATE="true"

plugins=(gitfast mvn archlinux battery colemak systemctl)

source $ZSH/oh-my-zsh.sh

. ~/lib/shell-configuration/bin/z/z.sh

fortune | ponysay
