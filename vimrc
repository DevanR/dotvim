autocmd!

call pathogen#incubate()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC EDITING CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
" allow unsaved background buffers and remember marks/undo for them
" set hidden
" " remember more commands and search history
set history=10000
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set laststatus=2
set showmatch
set incsearch
set hlsearch
" make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase
" highlight current line
set cursorline
set cmdheight=1
set switchbuf=useopen
set showtabline=2
set winwidth=79
" This makes RVM work inside Vim. I have no idea why.
set shell=bash
" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
set t_ti= t_te=
set scrolloff=3
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
let mapleader="'"
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
set number
set spell
" Have Vim clear terminal on exit
au VimLeave * :!clear
set foldmethod=syntax
set nofoldenable
set paste

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
-    set guioptions-=T
-    set guioptions+=e
-    set t_Co=256
-    set guitablabel=%M\ %t
-endif
-
set guifont=Bitstream\ Vera\ Sans\ Mono:h12
colorscheme solarized
set background=dark
set encoding=utf-8
set fileencoding=utf-8
set t_Co=256 " 256 colors
highlight CursorLineNR ctermbg=235 ctermfg=white

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STATUS LINE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
:set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC KEY MAPS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <leader><leader> <c-^>
" Save shortcut with leader s
noremap <Leader>s :update<CR>

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

""
"" Mouse
""
set mouse=a                                              " Mouse events
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>


" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" Save keystrokes when accessing command
nnoremap ; :

nmap <silent> ,/ :nohlsearch<CR>                         " Clear search history

""
"" Python Formatting
""
nmap <leader>p :PymodeLintAuto <cr> \| gggqG

""
"" Gundo
""
nmap <leader>u :GundoToggle <cr>
let g:gundo_width = 60
let g:gundo_preview_height = 45
let g:gundo_right = 1


nmap <leader>f :CommandT <cr>

""
"" AutoFormat
""
nmap <leader>a :Autoformat <CR>

""
"" Syntastic
""
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq = 0
let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'
let g:syntastic_html_tidy_ignore_errors = [
    \"trimming empty <i>",
    \"trimming empty <span>",
    \"<input> proprietary attribute \"autocomplete\"",
    \"proprietary attribute \"role\"",
    \"proprietary attribute \"hidden\"",
    \]
let g:syntastic_javascript_checkers = ['eslint']

""
"" Command T
""
let g:CommandTAcceptSelectionMap = '<C-t>'
let g:CommandTAcceptSelectionTabMap = '<CR>'

""
"" Pymode
""
au FileType python setlocal formatprg=autopep8\ -
let g:pymode = 1
let g:pymode_doc = 1
let g:pymode_run = 1
let g:pymode_lint = 1
let g:pymode_rope = 0
let g:pymode_motion = 0
let g:pymode_syntax = 1
let g:pymode_options = 0
let g:pymode_indent = 1
let g:pymode_folding = 1
let g:pymode_warnings = 0
let g:pymode_doc_bind = 'K'
"let g:pymode_lint_sort = []
let g:pymode_lint_message = 0
let g:pymode_lint_on_write = 0
let g:pymode_trim_whitespaces = 1
let g:pymode_lint_ignore = "F0401,C0111,C0301,E501,E265"
let g:pymode_quickfix_minheight = 3
let g:pymode_quickfix_maxheight = 12
"let g:pymode_rope_show_doc_bind = 'R'
"let g:pymode_rope_goto_definition_bind = 'D'
"let g:pymode_rope_organize_imports_bind = 'O'
let g:pymode_lint_checkers = ['pylint', 'pep8']
