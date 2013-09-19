" Pathogen
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

""
"" Basic Setup
""
set nocompatible      " Use vim, no vi defaults
set number
"if version >= 703
"    set rnu            " Show relative line number
"endif
set ruler             " Show line and column number
set spell
set backspace=indent,eol,start
set cursorline

" Disabled due to compatibility with SnipMate plugin
"set paste             " Eliminates auto-tabbing with Copy/Paste

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

set guifont=Bitstream\ Vera\ Sans\ Mono:h14
""set guifont=Source\ Code\ Pro:h14
syntax enable         " Turn on syntax highlighting allowing local overrides
colorscheme solarized
set background=dark
set encoding=utf-8    " Set default encoding to UTF-8
set fileencoding=utf-8

""
"" Whitespace
""
set nowrap                        " don't wrap lines
set tabstop=4                     " a tab is four spaces
set shiftwidth=4                  " an autoindent (with <<) is two spaces
set expandtab                     " use spaces, not tabs
set backspace=indent,eol,start    " backspace through everything in insert mode
set smartindent                   " When searching try to be smart about cases

""
"" Searching
""
set showmatch  " Show matching brackets when text indicator is over them
set hlsearch    " highlight matches
set incsearch   " incremental searching
"set ignorecase  " searches are case insensitive...
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
"" Status line
""
if has("statusline") && !&cp
    set laststatus=2  " always show the status bar

    " Start the status line
    set statusline=%f\ %m\ %r
    set statusline+=Line:%l/%L[%p%%]
    set statusline+=Col:%v
    set statusline+=Buf:#%n
    set statusline+=[%b][0x%B]
endif

""
"" Input Mappings
""
let mapleader = ","
set mouse=a                                              " Mouse events
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>

nmap <leader>md :%!/usr/bin/Markdown.pl --html4tags <cr> " Markdown to HTML
noremap <Leader>s :update<CR>                            " Quick save
nmap <leader>t :TagbarToggle<CR>                         " Toggle Tagbar
nmap <leader>gd :Gdiff<CR>                               " Fugitive diff
nmap <leader>gs :Gstatus<CR>                             " Fugitive status
nmap <leader>gc :Gcommit<CR>                             " Fugitive commit
nmap <leader>gb :Gblame<CR>                              " Fugitive blame
nmap <leader>n :NERDTreeToggle<CR>                       " Toggle NERDTree
nmap <leader>u :GundoToggle<CR>                          " Toggle Gundo

""
"" Fugitive
""
set previewheight=20
