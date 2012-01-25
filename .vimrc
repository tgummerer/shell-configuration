" .vimrc
" Inspiration again by Steve Losh (He is my new command line hero)

" Preamble {{{

call pathogen#infect()
filetype off
filetype plugin indent on
set nocompatible            " Enable vim features
set ofu=syntaxcomplete#Complete

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
set t_Co=256                                    " turn on 256 color mode
set incsearch
set hlsearch
set mouse=a                                     " Mouse, just if needed
set showcmd
set completeopt=longest,menuone,preview         " Easier completion
set showmatch                                   " Shows the matching parentheses 
" when you type a closing or opening parentheses
" Features that were in steves .vimrc, but I don't like
" set cursorline (Underline current line)

" }}}

" Line return {{{
" Make sure Vim returns to the same line when you reopen a file.
" Thanks, Amit
augroup line_return
    au!
    au BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \     execute 'normal! g`"zvzz' |
                \ endif
augroup END

" }}}

" Powerline {{{

let g:Powerline_symbols = "fancy"

" }}}

" Supertab {{{

let g:SuperTabDefaultCompletionType = "<c-n>"
"let g:SuperTabLongestHighlight = 1

"}}}

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

" Handy stuff {{{
" Save when losing focus
au FocusLost * :wa

" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null

inoremap <C-B> <C-O>yiW<End>=<C-R>=<C-R>0<CR>

" Leader {{{

let mapleader = ","
let maplocalleader = "\\"

" }}}

" }}}

" Tabs, spaces, wrapping {{{

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
" No automatic wrapping, I have a big screen
"set wrap
"set textwidth=80
"set formatoptions=qrn1
"set colorcolumn=+1

" }}}

" Backups {{{

set nobackup
set noswapfile

" }}}

" Color scheme {{{

syntax on
set background=dark
colorscheme wombat256
highlight ColorColumn ctermbg=8

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

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


"set statusline+=%#redbar#               " Highlight the following as a warning.
"set statusline+=%{SyntasticStatuslineFlag()} " Syntastic errors.
"set statusline+=%*                           " Reset highlighting.

set statusline+=%=   " Right align.

" Branch of the git repository we are currently in
set statusline+=%{fugitive#statusline()}
set statusline+=\    " Space.

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
" Up and down are more logical with g..
nnoremap <silent> k gk
nnoremap <silent> j gj
" Maybe worth a try? remapping jj to <ESC>
inoremap jj <Esc>

" }}}

" Folds {{{
" Space will toggle folds!
nnoremap <space> za
vnoremap <space> zf

" Save folds for next time
au BufWinLeave * mkview
au BufWinEnter * silent loadview

" }}}

" Shell {{{

function! s:ExecuteInShell(command) " {{{
    let command = join(map(split(a:command), 'expand(v:val)'))
    let winnr = bufwinnr('^' . command . '$')
    silent! execute  winnr < 0 ? 'botright vnew ' . fnameescape(command) : winnr . 'wincmd w'
    setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap nonumber
    echo 'Execute ' . command . '...'
    silent! execute 'silent %!'. command
    silent! redraw
    silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
    silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . command . ''')<CR>:AnsiEsc<CR>'
    silent! execute 'nnoremap <silent> <buffer> q :q<CR>'
    silent! execute 'AnsiEsc'
    echo 'Shell command ' . command . ' executed.'
endfunction " }}}
command! -complete=shellcmd -nargs=+ Shell call s:ExecuteInShell(<q-args>)
nnoremap <leader>! :Shell 

" }}}

