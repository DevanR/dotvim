autocmd!

call plug#begin('~/.vim/plugged')
" Make sure you use single quotes

Plug 'altercation/vim-colors-solarized'
Plug 'Chiel92/vim-autoformat'
Plug 'tmhedberg/SimpylFold'

"Plug 'davidhalter/jedi-vim'
"Plug 'tpope/vim-fugitive'
"Plug 'wincent/command-t'
"Plug 'ervandew/supertab'
"Plug 'sjl/gundo.vim'
"Plug 'vim-syntastic/syntastic'

"Plug 'w0rp/ale'
"Plug 'pangloss/vim-javascript'
"Plug 'jelera/vim-javascript-syntax'
"Plug 'elzr/vim-json'
"Plug 'mxw/vim-jsx'
"Plug 'jbgutierrez/vim-babel'
"Plug 'ekalinin/Dockerfile.vim'


" Add plugins to &runtimepath
call plug#end()

autocmd VimEnter *
			\ if !empty(filter(copy(g:plugs), '!isdirectory(v:val.dir)'))
			\|  PlugInstall | q
			\| endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC EDITING CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" allow unsaved background buffers and remember marks/undo for them
" set hidden
" " remember more commands and search history
set history=10000
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent
set laststatus=2
set showmatch
set incsearch
set hlsearch
" make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase
" highlight current line
set cursorline
if has('autocmd')
	autocmd WinEnter * setlocal cursorline
	autocmd WinLeave * setlocal nocursorline
endif
set cmdheight=1
set switchbuf=useopen
set showtabline=2
set winwidth=79
" This makes RVM work inside Vim. I have no idea why.
set shell=bash
" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
set t_ti= t_te=
set nobackup
set nowritebackup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backspace=indent,eol,start
set showcmd
" Enable highlighting for syntax
syntax on
" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
filetype plugin indent on
" use emacs-style tab completion when selecting files, etc
set wildmode=longest,list
let mapleader=","
" Fix slow O inserts
:set timeout timeoutlen=1000 ttimeoutlen=100
" Normally, Vim messes with iskeyword when you open a shell file. This can
" leak out, polluting other file types even after a 'set ft=' change. This
" variable prevents the iskeyword change so it can't hurt anyone.
let g:sh_noisk=1
" Modelines (comments that set vim options on a per-file basis)
set modeline
set modelines=3
" Insert only one space when joining lines that contain sentence-terminating
" punctuation like `.`.
set nojoinspaces
" If a file is changed outside of vim, automatically reload it without asking
set autoread
set number relativenumber
set spell
" Have Vim clear terminal on exit
au VimLeave * :!clear
set foldmethod=syntax
set nofoldenable
" More natural split creation
set splitbelow
set splitright
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CUSTOM AUTOCMDS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup vimrcEx
	" Clear all autocmds in the group
	autocmd!
	autocmd FileType text setlocal textwidth=78
	" Jump to last cursor position unless it's invalid or in an event handler
	autocmd BufReadPost *
				\ if line("'\"") > 0 && line("'\"") <= line("$") |
				\   exe "normal g`\"" |
				\ endif
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLOR
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("gui_running")
	set guioptions-=T
	set guioptions+=e
	set t_Co=256
	set guitablabel=%M\ %t
endif

set guifont=Bitstream\ Vera\ Sans\ Mono:h12

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Solarized options
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
colorscheme solarized
set background=dark

set encoding=utf-8
set fileencoding=utf-8
highlight CursorLineNR ctermbg=235 ctermfg=white

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STATUS LINE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC KEY MAPS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Save shortcut with leader s
noremap <Leader>s :update<CR>

" Shortcut for bms test
"noremap <leader>t :w\|:silent !echo "cd Workspace/git-bskyb-com/bms/ && source ~/.virtualenvs/bms/bin/activate && ./manage.py test utils" > ~/test-commands<CR>
noremap <leader>t :w\|:silent !echo "cd Workspace/git-bskyb-com/bms/ && source ~/.virtualenvs/bms/bin/activate && fab test" > ~/test-commands<CR>


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
set noerrorbells visualbell t_vb=
if has('autocmd')
	autocmd GUIEnter * set visualbell t_vb=
endif
set novisualbell
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

nmap <silent> ,/ :nohlsearch<CR>                         " Clear search history

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Gundo
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>u :GundoToggle <cr>
let g:gundo_width = 60
let g:gundo_preview_height = 45
let g:gundo_right = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" AutoFormat
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>a :Autoformat<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" All: AutoFormat & Python Formatter & Save & Sort & Save
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>f :Autoformat<CR> \| :0,$!yapf<CR> \| :update<CR> \| :!isort %<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" ALE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set nocompatible
"filetype off
"let &runtimepath.=',~/.vim/bundle/ale'
"filetype plugin on
"" Write this in your vimrc file
"let g:ale_lint_on_save = 1
"let g:ale_lint_on_text_changed = 0
"" You can disable this option too
"" if you don't want linters to run on opening a file
"let g:ale_lint_on_enter = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Javascript
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:jsx_ext_required = 0 " Allow JSX in normal JS files
autocmd Filetype javascript setlocal ts=4 sts=4 sw=4
autocmd Filetype html setlocal ts=2 sts=2 sw=2

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" YAPF Python Formatter
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType python nnoremap <leader>p :0,$!yapf<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" iSort
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType python nnoremap <leader>i :!isort %<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Selecta
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Run a given vim command on the results of fuzzy selecting from a given shell
" command. See usage below.
function! SelectaCommand(choice_command, selecta_args, vim_command)
  try
    let selection = system(a:choice_command . " | selecta " . a:selecta_args)
  catch /Vim:Interrupt/
    " Swallow the ^C so that the redraw below happens; otherwise there will be
    " leftovers from selecta on the screen
    redraw!
    return
  endtry
  redraw!
  exec a:vim_command . " " . selection
endfunction

" Find all files in all non-dot directories starting in the working directory.
" Fuzzy select one of those. Open the selected file with :e.
nnoremap <leader>o :call SelectaCommand("find * -type f", "", ":tabe")<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" CommandT
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"nmap <leader>o :CommandT <CR>
"autocmd FileType python setlocal completeopt-=preview

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Syntastic
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"
"let g:syntastic_enable_signs=1
"let g:syntastic_auto_jump=1
"let g:syntastic_php_checkers=['php', 'phpcs', 'phpmd']
"let g:syntastic_json_checkers=['jsonlint', 'jsonval']
"let g:syntastic_twig_checkers=['twiglint']
"let g:syntastic_enable_highlighting=1
"let g:syntastic_echo_current_error=1
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
