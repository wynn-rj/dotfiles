" Set <LEADER>
let mapleader = ","

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
" fix for fish shell
set shell=/bin/bash
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Buffer explorer import
Plugin 'vim-scripts/bufexplorer.zip'
Plugin 'scrooloose/nerdcommenter'
Plugin 'L9'
Plugin 'vim-scripts/FuzzyFinder'
Plugin 'flazz/vim-colorschemes'
Plugin 'gcmt/taboo.vim'
Plugin 'junegunn/goyo.vim'
" Better support for Markdown
Plugin 'shime/vim-livedown'
" Plugins for Linux Kernel development
Plugin 'joe-skb7/cscope-maps'
" Color highlighting
Plugin 'morhetz/gruvbox'
Plugin 'chriskempson/base16-vim'
" Syntax Linting
Plugin 'w0rp/ale'
" Syntax pack
Plugin 'sheerun/vim-polyglot'
" Simple statusline
Plugin 'itchyny/lightline.vim'
" Git features
Plugin 'tpope/vim-fugitive'
" Silver-Searcher
Plugin 'mileszs/ack.vim'
" Golang developemtn
Plugin 'fatih/vim-go'
" Line completion
Plugin 'Valloric/YouCompleteMe'
" Rainbow Parentheses
Plugin 'kien/rainbow_parentheses.vim'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
" Put your non-Plugin stuff after this line

" ####################
" BEGIN CUSTOM CONFIGS
" ####################

"""""""""""""""""""
" General
"""""""""""""""""""
" Turn persistent undo on.
" Means that you can undo even when you close a buffer/VIM
try
    set undodir=~/.vim_runtime/temp_dirs/undodir
    set undofile
catch
endtry

set shiftwidth=4

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Set search settings
set ignorecase
set smartcase
set hlsearch
set incsearch

set encoding=utf8

" Use Unix as the standard filetype
set ffs=unix,mac,dos

" Indents
set cindent
set autoindent
set wrap "Wrap lines

" Get persistent undo
" Put plugins and dictionaries in this dir (also on Windows)
let vimDir = '$HOME/.vim'
let &runtimepath.=','.vimDir

" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
    let myUndoDir = expand(vimDir . '/undodir')
    " Create dirs
    call system('mkdir ' . vimDir)
    call system('mkdir ' . myUndoDir)
    let &undodir = myUndoDir
    set undofile
endif

" Use the mouse to resize panes
set mouse=a

" Enable folding
set foldmethod=indent
set foldlevel=99

"""""""""""""""""""
" Colors and Fonts
"""""""""""""""""""
" Enable syntax highlighting
syntax enable
syntax on

set t_Co=256
set background=dark

set termguicolors

colorscheme base16-eighties

:hi TabLineFill ctermfg=Blue ctermbg=DarkGray
:hi TabLine ctermfg=LightGray ctermbg=DarkGray
:hi TabLineSel ctermfg=White ctermbg=Blue
:hi Title ctermfg=DarkGray ctermbg=LightGray

" Preserve Transparency on URxvt
hi Normal ctermbg=none

" Highlight overly long lines
highlight OverLength ctermbg=red ctermfg=white guibg=#c44a4a
match OverLength /\%>80v.\+/
map <leader>hh :highlight OverLength none<cr>

"""""""""""""""""""""
" Moving around
"""""""""""""""""""""
" Treat long lines as break lines
map j gj
map k gk

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Move around windows intelligently
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Remember info about open buffers on close
set viminfo^=%

" Move between tabs
map <C-n> :tabn<cr>
map <C-p> :tabp<cr>

"""""""""""""""
" Status line
"""""""""""""""
" Always show the status line
set laststatus=2

""""""""""""""""""
" Spell Checking
""""""""""""""""""
" Press ,ss to toggle spell check
map <leader>ss :setlocal spell!<cr>

"Shortcuts to move around spell check
map <leader>sn ]s
map <leader>sp [s
map <leader>s? z=

""""""""""""""""""
" Misc Mappings
""""""""""""""""""

" Toggle paste mode
map <leader>pp :setlocal paste!<cr>

" Fast Saving
nmap <leader>w :w!<cr>

" Hard quit
nmap <leader>qq :q!<cr>

" Set soft wrap on
set wrap linebreak nolist

" Set tab width
set tabstop=4
set shiftwidth=4
set expandtab

" Create new line without entering insert
nmap <cr> o<Esc>

" Go around to errors
nmap <leader>cn :cnext<cr>
nmap <leader>cp :cprev<cr>

" Go around to locations
nmap <leader>n :lnext<cr>
nmap <leader>p :lprevious<cr>
nmap <leader>r :lrewind<cr>

" Splits
nmap <leader>\ :vsplit<cr>
nmap <leader>- :split<cr>

nmap <C-S>j :res -5<cr>
set splitbelow
set splitright

" Source
nmap <leader>so :source ~/.vimrc<cr>

" Allow local vimrcs
set exrc
set secure

""""""""""""""""""
" Plugin Config
""""""""""""""""""

" ALE (syntax checker)
let g:ale_lint_on_text_changed = 'never'
let g:ale_linters = {
    \ 'python': ['pylint'],
    \ 'golang': []
\}
let g:ale_python_flake8_options = '--max-line-length 140 --ignore F405,E2,E3,E722'
let g:ale_completion_enabled = 0


" bufExplorer plugin
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1
let g:bufExplorerFindActive=1
let g:bufExplorerSortBy='mru'
map <leader>o :BufExplorer<cr>

" Fuzzy Finder
nmap <leader>f :FufFile<cr>

" Goyo
nmap <leader>z :Goyo<cr>

" Lightline
let g:lightline = {
\ 'colorscheme': 'wombat',
\}

" Go-vim
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go nmap <leader>l <Plug>(go-lint)
au FileType go nmap <leader>d <Plug>(go-doc)
let g:go_metalinter_autosave = 1

" Taboo.vim
map <leader>, :TabooRename

" YouCompleteMe
let g:python_host_prog = "/usr/bin/python2"
let g:python3_host_prog = "/usr/bin/python3"
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_server_python_interpreter = '/usr/bin/python2'
let g:ycm_global_ycm_extra_conf = "~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"
let g:ycm_confirm_extra_conf=0
map <leader>. :YcmCompleter GoTo<cr>
map <leader>yg :YcmCompleter GoTo<cr>
map <leader>yi :YcmCompleter GoToInclude<cr>
map <leader>yd :YcmCompleter GoToDeclaration<cr>
map <leader>yt :YcmCompleter GetType<cr>
map <leader>yo :YcmCompleter GetDoc<cr>
map <leader>y0 :let ycm_auto_trigger = 0<cr>
map <leader>y1 :let ycm_auto_trigger = 1<cr>

" Fugitive (Git Wrapper)
" Open diffs in vertical splits
set diffopt+=vertical

" Rainbow parentheses
func! DisplayRainbow()
    :RainbowParenthesesLoadRound
    :RainbowParenthesesLoadSquare
    :RainbowParenthesesLoadBraces
    :RainbowParenthesesLoadChevrons
    :RainbowParenthesesToggle
endfunction
map <leader>tr :call DisplayRainbow()<cr>
let g:rbpt_colorpairs = [
    \ ['brown',       'SeaGreen3'],
    \ ['Darkblue',    'DarkOrchid3'],
    \ ['darkgray',    'cyan'],
    \ ['darkgreen',   'LightGray'],
    \ ['darkcyan',    'gold'],
    \ ['darkred',     'RoyalBlue3'],
    \ ['darkmagenta', 'SeaGreen3'],
    \ ['brown',       'DarkOrchid3'],
    \ ['gray',        'cyan'],
    \ ['black',       'LightGray'],
    \ ['darkmagenta', 'gold'],
    \ ['Darkblue',    'RoyalBlue3'],
    \ ['darkgreen',   'SeaGreen3'],
    \ ['darkcyan',    'DarkOrchid3'],
    \ ['darkred',     'cyan'],
    \ ['red',         'LightGray'],
    \ ]

" Ack/Ag (Silver Searcher)
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" Assembly
au BufEnter *.S
    \set tabstop=4
    \set softtabstop=4
    \set shiftwidth=4
    \set expandtab

" Python
au BufNewFile,BufRead *.py
    \set tabstop=4
    \set softtabstop=4
    \set shiftwidth=4
    \set textwidth=79
    \set expandtab
    \set autoindent
    \set fileformat=unix
let python_highlight_all=1
au FileType python nmap <leader>r :! ./% <cr>

" C++
au FileType cpp
    \set tabstop=4
    \set softtabstop=4
    \set shiftwidth=4
    \set expandtab
au BufNewFile,BufRead *.cpp nnoremap <leader>m :make!<cr>
au BufNewFile,BufRead *.cpp nmap <leader>r :! clear && ./%:r<cr>

" C (for kernel dev)
au FileType c.doxygen
    \set tabstop=4
    \set softtabstop=4
    \set shiftwidth=4
    \set expandtab
au BufNewFile,BufRead *.c nnoremap <leader>m :make!<cr>
au BufNewFile,BufRead *.c nmap <leader>r :make!<cr> :make! deploy<cr>
au BufNewFile,BufRead *.c nmap <leader>d :make! deploy<cr>

" Markdown
au FileType markdown nnoremap <leader>m :make!<cr>
au FileType markdown nnoremap <leader>r :LivedownToggle<cr>

" Git Commit
au FileType gitcommit setlocal spell

" Fix SConstruct
au FileType conf if expand('%:t') == 'SConstruct' | set ft=python | endif
" map <Leader>sc :if expand('%:t') == 'SConstruct' | set ft=python | endif<cr>




" Neovim
tnoremap <Esc> <C-\><C-n>
let g:ale_use_deprecated_neovim = 1

" netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 20
"  Pre-map refresh so Netrw it doesn't bind <c-l> when it loads
nmap <unique> <c-e> <Plug>NetrwRefresh 
map <leader>nn :Lexplore<cr>

set nu
let c_space_errors = 1
if expand('%:t') == 'SConscript' | set ft=python | endif
if expand('%:t') == 'SConstruct' | set ft=python | endif
