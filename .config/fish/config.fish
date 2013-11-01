set PATH "$HOME/lib/shell-configuration/bin" $PATH
set PATH "$HOME/lib/shell-configuration/.bin" $PATH
set PATH "$HOME/.cabal/bin" $PATH
set PATH "/opt/android-sdk/tools" $PATH
set PATH "/opt/android-sdk/platform-tools" $PATH

set JAVA_HOME "/opt/java6"
set PATH "/opt/java6/bin" $PATH
# Environment variables {{{

set BROWSER open
set TERM xterm-256color

set -g -x fish_greeting ''
set -g -x EDITOR vim

set -g -x COMMAND_MODE unix2003

alias g git
alias gl "git log --oneline --graph --decorate --all"
alias gs "git status -s"
alias gc "git commit"
alias gcp "git commit -pv"
alias gm "git commit -m"
alias ga "git add -p"
alias gg "git grep"
alias grc "git rebase --continue"

alias m "make -j6"
alias m0 "make -j6 O=0"
alias mt "make -j6 test"
alias mt0 "make -j6 O=0 test"

alias m "make -j6"
alias mt "make -j6 test"

alias .. "cd .."
alias ... "cd ../.."
alias .... "cd ../../.."
alias ..... "cd ../../../.."

alias 0 "amixer set Master 0%"
alias 15 "amixer set Master 15%"
alias 25 "amixer set Master 25%"
alias 50 "amixer set Master 50%"
alias 75 "amixer set Master 75%"
alias 100 "amixer set Master 100%"

alias e "emacsclient -c &"
alias et "emacsclient -t"
# }}}

# Z {{{

. ~/.config/fish/z.fish

#alias j 'z'
function j; z $argv; end

# }}}

. ~/.config/fish/git-prompt.fish

# Prompt {{{

set normal (set_color normal)
set magenta (set_color magenta)
set yellow (set_color yellow)
set green (set_color green)
set gray (set_color -o black)
set hg_promptstring "< on $magenta<branch>$normal>< at $yellow<tags|$normal, $yellow>$normal>$green<status|modified|unknown><update>$normal<
patches: <patches|join( → )|pre_applied($yellow)|post_applied($normal)|pre_unapplied($gray)|post_unapplied($normal)>>" 2>/dev/null

function hg_prompt
    # hg prompt --angle-brackets $hg_promptstring 2>/dev/null
end

function fish_prompt
    set last_status $status

    z --add "$PWD"
    
    set_color magenta
    printf '%s' (whoami)
    set_color normal
    printf ' at '

    set_color yellow
    printf '%s' (hostname|cut -d . -f 1)
    set_color normal
    printf ' in '

    set_color $fish_color_cwd
    printf '%s' (prompt_pwd)
    set_color normal

    hg_prompt
    __git_ps1
#    git_prompt

    if test $last_status -eq 0
        set_color normal
	printf ' ><((°> '
    else
        set_color red -o
        printf ' [%d] ><((ˣ> ' $last_status
    end

    set_color normal
end

# }}}


# Local Settings {{{

if test -s $HOME/.config/fish/local.fish
    source $HOME/.config/fish/local.fish
end

#normal }}}

if status --is-interactive
	command fortune -s | cowsay
end

