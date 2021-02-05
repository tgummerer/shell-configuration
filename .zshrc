ZSH=~/lib/oh-my-zsh

export TERM=xterm-256color
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export PERL5LIB=~/share/perl5/site_perl/

export ZSH_THEME="tgummerer"

export GOPATH=/home/tgummerer/dev/

PATH=/home/tommy/dev/src/camlistore.org/bin:~/dev/go/bin:~/dev/go_appengine:~/bin:~/dev/julia/julia-f0e428b145/bin/:/opt/android-sdk/tools/:/opt/android-sdk/platform-tools/:/home/tommy/.gem/ruby/2.2.0/bin:~/dev/exports64/drmemory/bin64/:~/.cabal/bin/:~/.bin/:/sw/bin:/opt/local/bin:~/Applications/android-sdk-mac_x86/platform-tools:~/Applications/android-ndk-r6b:$PATH
PATH=/usr/local/sicstus4.3.1/bin:$PATH
PATH=$GOPATH/bin:$PATH
PATH=/home/tommy/dev/bazel/output:$PATH
PATH=/home/tommy/dev/infer/infer/bin:$PATH
PATH=/home/tommy/.local/bin:$PATH
PATH=/usr/lib/ccache:$PATH
PATH=~/libexec/git-core:$PATH
export PATH

. $HOME/.asdf/asdf.sh

alias f='find . | grep'
alias fx='find . -type f | xargs grep'

alias g='git'
alias gl='git log --oneline --graph --decorate'
alias gla='git log --oneline --graph --decorate --all'
alias gs='git status -s'
alias gc='git commit'
alias gcne='git commit --amend --no-edit'
alias gpf='git push --force-with-lease'
alias ga='git add -A -p'
alias gg='git ack'
alias grc='git rebase --continue'

alias m="make -j12"
alias m0="make -j12 O=0"
alias mt="git test run"
alias mt0="make -j12 O=0 test"
alias smi="sudo make -j12 install"

function t {
	if test $# = 0
	then
		git test run --test=full HEAD
	else
		test_num=$1
		shift
		make -j12 && (cd t && "./t$test_num-"* "$@")
	fi
}

function wta {
	git worktree add -b tg/"$1" ../"$1"
	cd ../"$1"
}

alias sd="python manage.py syncdb"
alias rs="python manage.py runserver"

alias 0="amixer set Master 0%"
alias 15="amixer set Master 15%"
alias 25="amixer set Master 25%"
alias 50="amixer set Master 50%"
alias 75="amixer set Master 75%"
alias 100="amixer set Master 100%"

alias e="emacsclient -c &"
alias et="emacsclient -c"
alias en="emacsclient -n"
alias xen="xargs emacsclient -n"

alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'

alias open='xdg-open'
alias fuck='$(thefuck $(fc -ln -1))'

export EDITOR="emacsclient -c"

export LD_LIBRARY_PATH='/usr/local/lib'
export LD_RUN_PATH='/usr/local/lib'

DISABLE_AUTO_UPDATE="true"

plugins=(gitfast mvn archlinux battery colemak systemctl)

source $ZSH/oh-my-zsh.sh

. ~/lib/shell-configuration/bin/z/z.sh

fortune | cowsay -s -f $(ls /usr/share/cows/ | shuf -n1)

x-copy-region-as-kill () {
	zle copy-region-as-kill
	print -rn $CUTBUFFER | xsel -i
}
zle -N x-copy-region-as-kill
x-kill-region () {
	zle kill-region
	print -rn $CUTBUFFER | xsel -i
}
zle -N x-kill-region
x-yank () {
	CUTBUFFER=$(xsel -o -p </dev/null)
	zle yank
}

zle -N x-yank
bindkey -e '\eW' x-copy-region-as-kill
bindkey -e '^W' x-kill-region
bindkey -e '^Y' x-yank
bindkey -e '^N' history-search-forward
bindkey -e '^P' history-search-backward

# OPAM configuration
. /home/tommy/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

export ANDROID_SDK=/opt/android-sdk

eval $(ssh-agent)

export GO111MODULE=auto
export GOPROXY=off
export GOFLAGS=-mod=vendor

function worktree-list () {
	git for-each-ref --sort=committerdate \
	    $(g worktree list --porcelain | grep branch | sed 's/branch //') \
	    --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset)|%(color:red)%(objectname:short)%(color:reset)|%(contents:subject)|%(authorname)|(%(color:green)%(committerdate:relative)%(color:reset))' |
	column -ts '|'
}

function chpwd_profiles() {
    local profile context
    local -i reexecute

    context=":chpwd:profiles:$PWD"
    zstyle -s "$context" profile profile || profile='default'
    zstyle -T "$context" re-execute && reexecute=1 || reexecute=0

    if (( ${+parameters[CHPWD_PROFILE]} == 0 )); then
        typeset -g CHPWD_PROFILE
        local CHPWD_PROFILES_INIT=1
        (( ${+functions[chpwd_profiles_init]} )) && chpwd_profiles_init
    elif [[ $profile != $CHPWD_PROFILE ]]; then
        (( ${+functions[chpwd_leave_profile_$CHPWD_PROFILE]} )) \
            && chpwd_leave_profile_${CHPWD_PROFILE}
    fi
    if (( reexecute )) || [[ $profile != $CHPWD_PROFILE ]]; then
        (( ${+functions[chpwd_profile_$profile]} )) && chpwd_profile_${profile}
    fi

    CHPWD_PROFILE="${profile}"
    return 0
}
# Add the chpwd_profiles() function to the list called by chpwd()!
chpwd_functions=( ${chpwd_functions} chpwd_profiles )

zstyle ':chpwd:profiles:/home/tgummerer/work/git(|/|/*)' profile git
zstyle ':chpwd:profiles:/home/tgummerer/gh/git(|/|/*)' profile git
zstyle ':chpwd:profiles:/home/tgummerer/gh/github(|/|/*)' profile github

export DEFAULT_PATH=$PATH

# The following lines were added by compinstall
zstyle :compinstall filename '/home/tgummerer/.zshrc'

ssh-add -k
export PATH=/home/tgummerer/gh/awssume/master/bin:$PATH
export PATH=/usr/local/go/bin:$PATH

export MALLOC_CHECK_=3
export MALLOC_PERTURB_=$(($RANDOM % 255 + 1))

eval "$(rbenv init -)"
export PATH=/home/tgummerer/gh/awssume/master/bin:$PATH
source $HOME/.cargo/env
# The following lines were added by compinstall
zstyle :compinstall filename '/home/tgummerer/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
. /home/tgummerer/work/git/master/contrib/completion/git-completion.zsh

export SKIP_LINUX_SETUP=true

chpwd_profile_git() {
    [[ ${profile} == ${CHPWD_PROFILE} ]] && return 1
    print "chpwd(): Switching to profile: $profile"

    export PATH=$PATH:/home/tgummerer/work/git/meta
}

chpwd_profile_github() {
    [[ ${profile} == ${CHPWD_PROFILE} ]] && return 1
    print "chpwd(): Switching to profile: $profile"

    export PATH=/home/tgummerer/github-bin:$PATH
}

chpwd_profile_default() {
    [[ ${profile} == ${CHPWD_PROFILE} ]] && return 1
    print "chpwd(): Switching to profile: $profile"

    export PATH=$DEFAULT_PATH
}

# NixOS
export SSL_CERT_FILE=/etc/ssl/certs/ca-bundle.crt
