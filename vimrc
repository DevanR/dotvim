" Pathogen
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

""
"" Basic Setup
""

set nocompatible      " Use vim, no vi defaults
set number            " Show line numbers
set ruler             " Show line and column number
set spell
set paste             " Eliminates auto-tabbing with Copy/Paste

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
syntax enable         " Turn on syntax highlighting allowing local overrides
colorscheme solarized
set background=dark
set encoding=utf-8    " Set default encoding to UTF-8

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
set ignorecase  " searches are case insensitive...
set smartcase   " ... unless they contain at least one capital letter


""
"" Sound
""

set noerrorbells
set novisualbell
set t_vb=
set tm=500

""
"" File types
""

filetype plugin indent on " Turn on filetype plugins (:help filetype-plugin)

if has("autocmd")
  " In Makefiles, use real tabs, not tabs expanded to spaces
  au FileType make setlocal noexpandtab

  " Make sure all markdown files have the correct filetype set and setup wrapping
  au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} setf markdown
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

set mouse=a                                              " Mouse events
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>

nmap <leader>md :%!/usr/bin/Markdown.pl --html4tags <cr> " Markdown to HTML
