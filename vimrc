autocmd!

call plug#begin('~/.vim/plugged')
" Make sure you use single quotes

Plug 'fisadev/vim-isort'
Plug 'sheerun/vim-polyglot'
Plug 'tmhedberg/SimpylFold'
"Plug 'Chiel92/vim-autoformat'
Plug 'ambv/black'
Plug 'altercation/vim-colors-solarized'
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'

" Add plugins to &runtimepath
call plug#end()

autocmd VimEnter *
			\ if !empty(filter(copy(g:plugs), '!isdirectory(v:val.dir)'))
			\|  PlugInstall | q
			\| endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC EDITING CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" General
let mapleader=","
set nocompatible
set backspace=indent,eol,start
set history=1000
set showcmd
set showmode
set autoread
set hidden

" User Interface
set laststatus=2
set ruler
set wildmenu
set tabpagemax=40
set cursorline
set number
set relativenumber
set noerrorbells
set visualbell
set background=dark
set title

" Swap and Backup
set noswapfile
set nobackup
set nowb

" Indentation
set autoindent
filetype plugin indent on
set tabstop=4
set shiftwidth=2
set expandtab
set nowrap

" Search
set incsearch
set hlsearch
set ignorecase
set smartcase

" Text Rendering
set encoding=utf-8
set linebreak
set scrolloff=3
set sidescrolloff=5
syntax enable

" Misc
set confirm
set nomodeline
set nrformats-=octal
set shell=bash
set spell

"set cmdheight=1
"set switchbuf=useopen
"set showtabline=2
"set winwidth=79
"set t_ti= t_te= " Prevent Vim from clobbering the scrollback buffer.
"set wildmode=longest,list
":set timeout timeoutlen=1000 ttimeoutlen=100 " Fix slow O inserts
"set modeline
"set modelines=3
"set nojoinspaces
"set foldmethod=syntax
"set splitbelow
"set splitright
"highlight CursorLineNR ctermbg=235 ctermfg=white
"nmap <silent> ,/ :nohlsearch<CR> " Clear search history

" Normally, Vim messes with iskeyword when you open a shell file. This can
" leak out, polluting other file types even after a 'set ft=' change. This
" variable prevents the iskeyword change so it can't hurt anyone.
let g:sh_noisk=1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NETRW setting
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_winsize = 20

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLOR
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("gui_running")
	set guioptions-=T
	set guioptions+=e
	set t_Co=256
	set guitablabel=%M\ %t
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Solarized options
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
colorscheme solarized
set background=dark

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STATUS LINE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC KEY MAPS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use the space key to toggle folds
nnoremap <space> za
vnoremap <space> zf

" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Save shortcut with leader s
noremap <Leader>s :w<CR><CR>

" Shortcut for bms test
"noremap <leader>t :w\|:silent !echo "cd Workspace/git-bskyb-com/bms/ && source ~/.virtualenvs/bms/bin/activate && ./manage.py test utils" > ~/test-commands<CR>
noremap <leader>t :w\|:silent !echo "cd Workspace/git-bskyb-com/bms/ && source ~/.virtualenvs/bms/bin/activate && fab test" > ~/test-commands<CR>

" Shortcut to insert breakpoint
map ,d oimport pdb<CR>pdb.set_trace()<CR><ESC>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" InsertTime COMMAND
" Insert the current time
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command! InsertTime :normal a<c-r>=strftime('%F %H:%M:%S.0 %z')<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Bite the bullet
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Sound
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set noerrorbells
set visualbell
set tm=500

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Mouse
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set mouse=a                                              " Mouse events
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" Save keystrokes when accessing command
nnoremap ; :

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" All: AutoFormat & Python Formatter & Save & Sort & Save
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:formatter_yapf_style = 'pep8'
"nmap <leader>f :Autoformat<CR>
nmap <leader>f :Black<CR>
autocmd BufWritePost *.py execute ':Black'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" fzf
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set rtp+=/usr/local/opt/fzf
set rtp+=~/.fzf
nmap ; :Buffers<CR>
nmap <Leader>t :Tags<CR>
nmap <Leader>o :Files<CR>
nmap <Leader>a :Ag<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Javascript
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:jsx_ext_required = 0 " Allow JSX in normal JS files
autocmd Filetype javascript setlocal ts=4 sts=4 sw=4
autocmd Filetype html setlocal ts=2 sts=2 sw=2

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" iSort
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType python nnoremap <leader>i :!isort %<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" SimplyFold
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:SimpylFold_docstring_preview = 0
let g:SimpylFold_fold_docstring = 1
let b:SimpylFold_fold_docstring = 1
let g:SimpylFold_fold_import = 0
let b:SimpylFold_fold_import = 0

" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL
