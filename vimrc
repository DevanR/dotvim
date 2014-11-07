" Pathogen
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

""
"" Basic Setup
""
set nocompatible      " Use vim, no vi defaults
set number
set ruler             " Show line and column number
set spell
set backspace=indent,eol,start
set cursorline

""
"" Backups
""
set history=1000                            "store a large command history. Search using q:
set nobackup                                " Dont store pointless backup files                                                                 
set nowritebackup                           " See :help backup                                                              
set swapfile                                " Do use the swap file though incase of crash                                                              
set dir=~/.vim/swap//,/var/tmp//,/tmp//,.   " save swap files in one convenient location

""
"" UI
""
if has("gui_running")
    set guioptions-=T
    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

set guifont=Bitstream\ Vera\ Sans\ Mono:h12
syntax enable         " Turn on syntax highlighting allowing local overrides
colorscheme solarized
set background=dark
set encoding=utf-8    " Set default encoding to UTF-8
set fileencoding=utf-8

""
"" Whitespace
""
set nowrap                               " don't wrap lines
set tabstop=4                            " a tab is four spaces
set shiftwidth=4                         " an autoindent (with <<) is two spaces
set softtabstop=4                        " People like using real tab character instead of spaces because it makes it easier when pressing BACKSPACE or DELETE, since if the indent is using spaces it will take 4 keystrokes to delete the indent. Using this setting, however, makes VIM see multiple space characters as tabstops, and so <BS> does the right thing and will delete four spaces (assuming 4 is your setting).
set expandtab                            " use spaces, not tabs
set backspace=indent,eol,start           " backspace through everything in insert mode
set autoindent                           " Very painful to live without this (especially with Python)! It means that when you press RETURN and a new line is created, the indent of the new line will match that of the previous line. 
set smartindent                          " When searching try to be smart about cases
let &colorcolumn=join(range(81,999),",") " limit length of cursor line

""
"" Searching
""
set showmatch   " Show matching brackets when text indicator is over them
set hlsearch    " highlight matches
set incsearch   " incremental searching
set ignorecase  " searches are case insensitive...
set smartcase   " ... unless they contain at least one capital letter

""
"" Folding
""
set foldmethod=syntax
set foldlevelstart=1

let javaScript_fold=1         " JavaScript
let perl_fold=1               " Perl
let php_folding=1             " PHP
let r_syntax_folding=1        " R
let ruby_fold=1               " Ruby
let sh_fold_enabled=1         " sh
let vimsyn_folding='af'       " Vim script
let xml_syntax_folding=1      " XML

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
"" File types
""
filetype on     " Turn on filetype plugins (:help filetype-plugin)
filetype indent on 
filetype plugin on

if has("autocmd")
    " In Makefiles, use real tabs, not tabs expanded to spaces
    au FileType make setlocal noexpandtab

    " Make sure all markdown files have the correct filetype set and setup wrapping
    au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} setf markdown
    au FileType markdown call s:setupWrapping()

    " Treat JSON files like JavaScript
    au BufNewFile,BufRead *.json set ft=javascript

    " Remember last location in file, but not for commit messages.
    " see :help last-position-jump
    au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
                \| exe "normal! g`\"" | endif
endif

""
"" Input Mappings
""

set mouse=a                                              " Mouse events
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>

nmap <leader>md :%!/usr/bin/Markdown.pl --html4tags <cr> " Markdown to HTML
nmap <leader>t :TagbarToggle<CR>                         " Toggle Tagbar

nnoremap Q <nop>                                         " Leave Ex Mode

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
"" Fugitive
""
nmap <leader>gd :Gdiff<CR>                               " Fugitive diff
nmap <leader>gs :Gstatus<CR>                             " Fugitive status
nmap <leader>gc :Gcommit<CR>                             " Fugitive commit
nmap <leader>gb :Gblame<CR>                              " Fugitive blame
set previewheight=20

""
"" NERD Tree
""
nmap <leader>n :NERDTreeToggle<CR>                       " Toggle NERDTree

""
"" GitGutter
""
let g:gitgutter_highlight_lines = 0 " Turns off line highlighting by default

""
"" Syntastic
""
let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'

""
"" Pymode
""
let g:pymode = 1
let g:pymode_doc = 1
let g:pymode_run = 1
let g:pymode_lint = 1
let g:pymode_rope = 0
let g:pymode_motion =1
let g:pymode_syntax = 1
let g:pymode_options = 1
let g:pymode_indent = 1
let g:pymode_folding = 1
let g:pymode_warnings = 1
let g:pymode_doc_bind = 'K'
let g:pymode_lint_sort = []
let g:pymode_lint_message = 1
let g:pymode_lint_on_write = 1
let g:pymode_trim_whitespaces = 1
let g:pymode_max_line_length = 120
let g:pymode_quickfix_minheight = 3
let g:pymode_quickfix_maxheight = 6
"let g:pymode_rope_show_doc_bind = 'R'
"let g:pymode_rope_goto_definition_bind = 'D'
"let g:pymode_rope_organize_imports_bind = 'O'
let g:pymode_lint_checkers = ['pyflakes', 'pep8']

