" .vimrc
" Inspiration again by Steve Losh (He is my new command line hero) 

" Preamble {{{

call pathogen#infect()
filetype off
filetype plugin indent on
set nocompatible            " Enable vim features
"set ofu=syntaxcomplete#Complete

" }}}

" Leader {{{
" Map it at the beginning, otherwise it might not work for some commands

let mapleader = ","
let maplocalleader = "\\"

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
set number                                      " Show line numbers. Looks good with badwolf
" when you type a closing or opening parentheses
" Features that were in steves .vimrc, but I don't like
" set cursorline (Underline current line)

" }}}

" Auto commands {{{
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType cpp set omnifunc=omni#cpp#complete#Main
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

" CtrlP {{{

let g:ctrlp_extensions = ['tag']
let g:ctrlp_cmd = 'CtrlPMixed'

" }}}

" Omni completion {{{
"set omnifunc=syntaxcomplete#Complete " override built-in C omnicomplete with C++ OmniCppComplete plugin
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
set completeopt=menuone,menu,longest
" }}}

" Update ctags {{{
function! Update_tags()
    let command = '"make TAGS"'
    silent! execute 'silent %!'. command
    echo 'execute' . command
endfunction
nnoremap <leader>u call Update_tags()
" }}}

" Supertab {{{

"let g:SuperTabDefaultCompletionType = "<c-n>"
"let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
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

" Abbreviations {{{

iabbrev @@ info@tgummerer.com
iabbrev ccopy Copyright &copy; 2012 Thomas Gummerer. All rights reserved.

" }}}

" Easy file editing and sourcing {{{

nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" }}}

" Show trailing whitespace {{{
augroup trailing
    au!
    au InsertEnter * :set listchars-=trail:⌴
    au InsertLeave * :set listchars+=trail:⌴
augroup END
" }}}

" Highlight words in a specific color {{{
"nnoremap <silent> <leader>h1 :execute 'match W1 /\<<c-r><c-w>\>/'<cr>

"hi W1 guibg=#aeee00 guifg=#000000 ctermbg=154 ctermfg=16

" Clear the matches
"nnoremap <silent> <leader><space> :noh<cr>:call clearmatches()<cr>
" }}}

" }}}

" Tabs, spaces, wrapping {{{

set tabstop=8
set shiftwidth=8
set softtabstop=8
set noexpandtab

set wrap
set textwidth=80
set formatoptions=qrn1
set colorcolumn=+1

" }}}

" Backups {{{

set nobackup
set nowritebackup
set noswapfile

" }}}

" Color scheme {{{

syntax on
set background=dark
colorscheme molokai
highlight ColorColumn ctermbg=8

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" }}}

" Remaps and make stuff work with colemak {{{
" Create Blank Newlines and stay in Normal mode
nnoremap <silent> zj o<Esc>
nnoremap <silent> zk O<Esc>
" Map ; to : Convenient.
" Don't do it the other way round, since I never use ; and it may conflict with
" some plugins
nnoremap ; :
" Up and down are more logical with g..
nnoremap <silent> k gk
nnoremap <silent> j gj

" Easier escaping
inoremap hh <Esc>

" Move with usual keys in insert mode by pressing ctrl
inoremap <C-l> <C-o>l
inoremap <C-h> <C-o>h
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k

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

