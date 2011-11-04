"Prevent Vim from emulating vi
set nocompatible

set background=dark

"Enable syntax highlighting
filetype on 
filetype plugin on
syntax enable

filetype plugin indent on

"Automatic help for indenting
set autoindent
set smartindent

"Tabs
set expandtab
set smarttab

" Cool tab completion stuff
set wildmenu
set wildmode=list:longest,full

" Create Blank Newlines and stay in Normal mode
nnoremap <silent> zj o<Esc>
nnoremap <silent> zk O<Esc>

" Swap ; and :  Convenient.
nnoremap ; :
nnoremap : ;

" Space will toggle folds!
nnoremap <space> za

" Up and down are more logical with g..
nnoremap <silent> k gk
nnoremap <silent> j gj

" Ignoring case is a fun trick
set ignorecase

" And so is Artificial Intellegence!
set smartcase

" Statusline
set laststatus=2

"Mouse
set mouse=a

" This shows what you are typing as a command.
set showcmd

"Maybe worth a try? remapping jj to <ESC>
inoremap jj <Esc>

"Use 4 space tabs instead of 8 space tabs
set tabstop=4
set shiftwidth=4
set softtabstop=4

"Shows the matching parentheses when you type a closing or opening parentheses
set showmatch

"Show status line in each window
set ruler

"Incremental search, searches as you enter the search term
set incsearch
set hlsearch

" No backup etc.
set nobackup
set nowritebackup
set noswapfile

" For screen
if match($TERM, "screen")!=-1
	set term=xterm
endif

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null

" Color scheme
colorscheme desert
