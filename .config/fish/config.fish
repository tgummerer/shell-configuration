set PATH "$HOME/lib/shell-configuration/bin" $PATH
# Environment variables {{{

set BROWSER open
set TERM xterm-256color

set -g -x fish_greeting ''
set -g -x EDITOR vim

set -g -x COMMAND_MODE unix2003

alias g git
alias gl "git log --oneline --graph"
alias gs "git status -s"
alias gc "git commit"
alias gm "git commit -m"
alias ga "git add -p"
alias m "make -j6"
alias mt "make -j6 test"

alias m "make -j4"
alias mt "make -j4 test"

# }}}

# Z {{{

. ~/src/z-fish/z.fish

alias j 'z'

# }}}

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

function git_prompt
    if git root >/dev/null 2>&1
        set_color normal
        printf ' on '
        set_color magenta
	printf (git currentbranch ^/dev/null)
        set_color green
        git_prompt_status
        set_color normal
    end
end

function fish_prompt
    set last_status $status

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
    git_prompt

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

