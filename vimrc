autocmd!

call pathogen#incubate()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC EDITING CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
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
set ignorecase smartcase
set cursorline
set cmdheight=1
set switchbuf=useopen
set showtabline=2
set winwidth=79
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
syntax on
filetype plugin indent on
set wildmenu
let mapleader=","
:set timeout timeoutlen=1000 ttimeoutlen=100
" Normally, Vim messes with iskeyword when you open a shell file. This can
" leak out, polluting other file types even after a 'set ft=' change. This
" variable prevents the iskeyword change so it can't hurt anyone.
let g:sh_noisk=1
" Modelines (comments that set vim options on a per-file basis)
set modeline
set modelines=3
set nojoinspaces
set autoread
set number
set spell
set fileformat=dos
au VimLeave * :!clear

set tabstop=4       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.

set shiftwidth=4    " Indents will have a width of 4

set softtabstop=4   " Sets the number of columns for a TAB

set expandtab       " Expand TABs to spaces

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

  "for ruby, autoindent with two spaces, always expand tabs
  autocmd FileType ruby,haml,eruby,yaml,html,javascript,sass,cucumber set ai sw=2 sts=2 et

  autocmd! BufRead,BufNewFile *.sass setfiletype sass 

  autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:&gt;
  autocmd BufRead *.markdown  set ai formatoptions=tcroqn2 comments=n:&gt;

  " Indent p tags
  autocmd FileType html,eruby if g:html_indent_tags !~ '\\|p\>' | let g:html_indent_tags .= '\|p\|li\|dt\|dd' | endif

  " Don't syntax highlight markdown because it's often wrong
  autocmd! FileType mkd setlocal syn=off

  " Leave the return key alone when in command line windows, since it's used
  " to run commands there.
  autocmd! CmdwinEnter * :unmap <cr>
  autocmd! CmdwinLeave * :call MapCR()

  " *.md is markdown
  autocmd! BufNewFile,BufRead *.md setlocal ft=

  " indent slim two spaces, not four
  autocmd! FileType *.slim set sw=2 sts=2 et
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UI
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("gui_running")
    set guioptions-=T
    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

set guifont=Bitstream\ Vera\ Sans\ Mono:h12
colorscheme solarized
set background=dark
set encoding=utf-8
set fileencoding=utf-8
:set t_Co=256 " 256 colors

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STATUS LINE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
:set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <expr> <tab> InsertTabWrapper()
inoremap <s-tab> <c-n>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" InsertTime COMMAND
" Insert the current time
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command! InsertTime :normal a<c-r>=strftime('%F %H:%M:%S.0 %z')<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Diff tab management: open the current git diff in a tab
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command! GdiffInTab tabedit %|vsplit|Gdiff
nnoremap <leader>d :GdiffInTab<cr>
nnoremap <leader>D :tabclose<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RemoveFancyCharacters COMMAND
" Remove smart quotes, etc.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RemoveFancyCharacters()
    let typo = {}
    let typo["“"] = '"'
    let typo["”"] = '"'
    let typo["‘"] = "'"
    let typo["’"] = "'"
    let typo["–"] = '--'
    let typo["—"] = '---'
    let typo["…"] = '...'
    :exe ":%s/".join(keys(typo), '\|').'/\=typo[submatch(0)]/ge'
endfunction
command! RemoveFancyCharacters :call RemoveFancyCharacters()

""
"" Bite the bullet
""
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

""
"" Searching
""
set showmatch
set incsearch
set hlsearch
set ignorecase smartcase

""
"" Folding
""
set foldmethod=manual
set nofoldenable

""
"" Sound
""
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif
set novisualbell
set tm=500

""
"" Input Mappings
""
" Change the mapleader from \ to 
let mapleader="'"

" Align selected lines
vnoremap <leader>ib :!align<cr>

" Insert a hash rocket with <c-l>
imap <c-l> <space>=><space>


set mouse=a                                              " Mouse events
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>

nmap <leader>md :%!/usr/bin/Markdown.pl --html4tags <cr> " Markdown to HTML

nnoremap Q <nop>                                         " Leave Ex Mode

nmap <leader>e :Explore <cr>                             " Vim Explore mode
nmap <leader>v :Vexplore <cr>                            " Vim Explore mode vertical split
nmap <leader>s :Sexplore <cr>                            " Vim Explore mode horizontal split
nmap <leader>t :Texplore <cr>                            " Vim Explore mode new tab

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" Save keystrokes when accessing command
nnoremap ; :

nmap <silent> ,/ :nohlsearch<CR>                         " Clear search history

cmap w!! w !sudo tee % >/dev/null                        " Force writing of sudo files with "w!!"

set pastetoggle=<F2>                                     " Shortcut for pastemode

" "
" " Easy window navigation
" "
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" "
" " Swap windows
" "
" " Instructions
" " Move to the window to mark for the swap via ctrl-w movement
" " Type ;m
" " Move to the window you want to swap
" " Type ;sw
function! MarkWindowSwap()
    let g:markedWinNum = winnr()
endfunction

function! DoWindowSwap()
    "Mark destination
    let curNum = winnr()
    let curBuf = bufnr( "%" )
    exe g:markedWinNum . "wincmd w"
    "Switch to source and shuffle dest->source
    let markedBuf = bufnr( "%" )
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' curBuf
    "Switch to dest and shuffle source->dest
    exe curNum . "wincmd w"
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' markedBuf 
endfunction

nmap <silent> <leader>m :call MarkWindowSwap()<CR>
nmap <silent> <leader>sw :call DoWindowSwap()<CR>


""
"" Python Formatting
""
nmap <leader>p :PymodeLintAuto <cr> \| gggqG

""
"" CtrlP
""
let g:ctrlp_map = '<C-p>'

""
"" Gundo
""
nmap <leader>u :GundoToggle <cr>
let g:gundo_width = 60
let g:gundo_preview_height = 45
let g:gundo_right = 1

""
"" AutoFormat
""
nmap <leader>a :Autoformat <cr>

""
"" Syntastic
""
let g:syntastic_check_on_open=1
let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
let g:syntastic_html_tidy_ignore_errors = [
    \"trimming empty <i>",
    \"trimming empty <span>",
    \"<input> proprietary attribute \"autocomplete\"",
    \"proprietary attribute \"role\"",
    \"proprietary attribute \"hidden\"",
    \]
let g:syntastic_javascript_checkers = ['eslint']


""
"" Pymode
""
au FileType python setlocal formatprg=autopep8\ -
let g:pymode = 1
let g:pymode_doc = 0
let g:pymode_run = 0
let g:pymode_lint = 1
let g:pymode_rope = 0
let g:pymode_motion = 0
let g:pymode_syntax = 1
let g:pymode_options = 0
let g:pymode_indent = 1
let g:pymode_folding = 1
let g:pymode_warnings = 1
let g:pymode_doc_bind = 'K'
"let g:pymode_lint_sort = []
let g:pymode_lint_message = 1
let g:pymode_lint_on_write = 1
let g:pymode_trim_whitespaces = 1
let g:pymode_lint_ignore = "E501"
let g:pymode_quickfix_minheight = 3
let g:pymode_quickfix_maxheight = 12
"let g:pymode_rope_show_doc_bind = 'R'
"let g:pymode_rope_goto_definition_bind = 'D'
"let g:pymode_rope_organize_imports_bind = 'O'
let g:pymode_lint_checkers = ['pylint', 'pep8']
