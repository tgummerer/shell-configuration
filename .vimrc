" .vimrc
" Inspiration again by Steve Losh (He is my new command line hero)

" Preamble {{{

filetype off
filetype plugin indent on
set nocompatible            " Enable vim features

" }}}

" Basic options {{{
" Just copy and pasted here, better find out what's going on
set encoding=utf-8
set modelines=0
set autoindent
set showmode
set showcmd
set hidden
set visualbell
set ttyfast
set ruler
set backspace=indent,eol,start
set nonumber
set norelativenumber
set laststatus=2
set history=1000
set cpoptions+=J
set shell=/bin/zsh
set lazyredraw
set matchtime=3
set splitbelow
set splitright
set ttimeout
set notimeout
set nottimeout
set autowrite
set shiftround
set autoread
set title
set dictionary=/usr/share/dict/words
set ignorecase
set smartcase
" Features that were in steves .vimrc, but I don't like
" set cursorline (Underline current line)

" }}}


" Wildmenu completion {{{

set wildmenu
set wildmode=list:longest

set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit

set wildignore+=*.luac                           " Lua byte code

set wildignore+=migrations                       " Django migrations
set wildignore+=*.pyc                            " Python byte code

" }}}

" Save when losing focus
au FocusLost * :wa

" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="

" Tabs, spaces, wrapping {{{

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
" No automatic wrapping, I have a big screen
" set wrap
" set textwidth=80
" set formatoptions=qrn1
" set colorcolumn=+1

" }}}

" Backups {{{

set nobackup
set noswapfile

" }}}

" Color scheme {{{

syntax on
set background=dark
colorscheme molokai

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" }}}

" }}}

" Status line {{{

augroup ft_statuslinecolor
    au!

    au InsertEnter * hi StatusLine ctermfg=196 guifg=#FF3145
    au InsertLeave * hi StatusLine ctermfg=130 guifg=#CD5907
augroup END

set statusline=%f    " Path.
set statusline+=%m   " Modified flag.
set statusline+=%r   " Readonly flag.
set statusline+=%w   " Preview window flag.

set statusline+=\    " Space.

"set statusline+=%#redbar#                " Highlight the following as a warning.
"set statusline+=%{SyntasticStatuslineFlag()} " Syntastic errors.
"set statusline+=%*                           " Reset highlighting.

set statusline+=%=   " Right align.

" File format, encoding and type.  Ex: "(unix/utf-8/python)"
set statusline+=(
set statusline+=%{&ff}                        " Format (unix/DOS).
set statusline+=/
set statusline+=%{strlen(&fenc)?&fenc:&enc}   " Encoding (utf-8).
set statusline+=/
set statusline+=%{&ft}                        " Type (python).
set statusline+=)

" Line position and counts.
set statusline+=\ (line\ %l\/%L)

" }}}

" Remaps {{{
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
" Maybe worth a try? remapping jj to <ESC>
inoremap jj <Esc>

" }}}

"Mouse
set mouse=a

" This shows what you are typing as a command.
set showcmd

" Better Completion
set completeopt=longest,menuone,preview

" Shows the matching parentheses when you type a closing or opening parentheses
set showmatch

" Show status line in each window
set ruler

" Incremental search, searches as you enter the search term
set incsearch
set hlsearch

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null
