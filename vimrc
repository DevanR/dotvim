" Pathogen
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

set guifont=Bitstream\ Vera\ Sans\ Mono:h14
"set guifont=Source\ Code\ Pro\ Light:h17

" Open NerdTree automatically
" autocmd vimenter * NERDTree

set spell
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

" Color Scheme
colorscheme solarized
set background=dark

" Syntax Highlighting
syntax on
filetype on

" Eliminates auto-tabbing with Copy/Paste
set paste

"JSON formatting with \jt command, using JSON::XS perl module
map <leader>jt  <Esc>:%!json_xs -f json -t json-pretty<CR>

" JSON syntax highlighting
au BufRead,BufNewFile *.json set filetype=json
au! Syntax json source /Users/dr/.janus/syntax/json.vim

" Jinja syntax highlighting
au BufRead,BufNewFile *.jinja set filetype=jinja
au! Syntax jinja source /Users/dr/.janus/syntax/jinja.vim

" Mouse events
set mouse=a
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>

" Automatically save folds
au BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview

"Markdown to HTML  
nmap <leader>md :%!/usr/bin/Markdown.pl --html4tags <cr>
