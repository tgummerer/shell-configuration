# Path to your oh-my-zsh configuration.
ZSH=~/lib/oh-my-zsh

export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
export ZSH_THEME="tgummerer"

# Set Path
PATH=/sw/bin:/opt/local/bin:~/Applications/android-sdk-mac_x86/platform-tools:~/Applications/android-ndk-r6b:$PATH

# Aliases
alias t='python ~/lib/shell-configuration/tools/t/t.py --task-dir ~/tasks --list tasks'

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want disable red dots displayed while waiting for completion
# DISABLE_COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git svn)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
