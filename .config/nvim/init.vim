"     _            ____                 _
"    / \   ___ ___| __ ) _ __ ___  __ _| | _____ _ __
"   / _ \ / __/ __|  _ \| '__/ _ \/ _` | |/ / _ \ '__|
"  / ___ \\__ \__ \ |_) | | |  __/ (_| |   <  __/ |
" /_/   \_\___/___/____/|_|  \___|\__,_|_|\_\___|_|
"
" http://www.gitlab.com/assbreaker/
"
" My neovim config. Not much to see here; just some pretty standard stuff.

"#####################################################
"################         SETs        ################
"#####################################################

syntax on                " Enable syntax highlight
set nu                   " Enable line numbers
set relativenumber       " Enable relative numbers
set tabstop=4            " Show existing tab with 4 spaces width
set softtabstop=4        " Show existing tab with 4 spaces width
set shiftwidth=4         " When indenting with '>', use 4 spaces width
set expandtab            " On pressing tab, insert 4 spaces
set smarttab             " insert tabs on the start of a line according to shiftwidth
set smartindent          " Automatically inserts one extra level of indentation in some cases
set hidden               " Hides the current buffer when a new file is openned
set incsearch            " Incremental search
set ignorecase           " Ingore case in search
set smartcase            " Consider case if there is a upper case character
set scrolloff=12         " Minimum number of lines to keep above and below the cursor
set colorcolumn=100      " Draws a line at the given line to keep aware of the line size
set signcolumn=yes       " Add a column on the left. Useful for linting
set cmdheight=1          " Give more space for displaying messages
set updatetime=100       " Time in miliseconds to consider the changes
set encoding=utf-8       " The encoding should be utf-8 to activate the font icons
set fileencoding=utf-8   " The encoding should be utf-8 to activate the font icons
set nobackup             " No backup files
set nowritebackup        " No backup files
set noshowmode           " No show mode below airline
set splitright           " Create the vertical splits to the right
set splitbelow           " Create the horizontal splits below
set autoread             " Update vim after file update from outside
set mouse=a              " Enable mouse support
set nohlsearch           " No highlight words after search
set laststatus=2         " Always show the status bar
set guicursor=            " Use block cursor in insert mode
set clipboard+=unnamedplus " Use system clipboard
filetype on              " Detect and set the filetype option and trigger the FileType Event
filetype plugin on       " Load the plugin file for the file type, if any
filetype indent on       " Load the indent file for the file type, if any

"#####################################################
"################       PLUGINS       ################
"#####################################################

call plug#begin('~/.config/nvim/plugged/')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'ap/vim-css-color'
Plug 'joshdick/onedark.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'mg979/vim-visual-multi'
Plug 'tc50cal/vim-terminal'
Plug 'preservim/tagbar'
Plug 'raimondi/delimitmate'
Plug 'junegunn/goyo.vim'
" Plug 'neoclide/coc.nvim'
" Plug 'dracula/vim', { 'as': 'dracula' }
" Plug 'rafi/awesome-vim-colorschemes'

call plug#end()

" Set custom colorscheme
colorscheme onedark

"#####################################################
"################         MAPs        ################
"#####################################################

" Map leader to Space
let mapleader = " "

" Map Caps Lock to Escape
au VimEnter * silent! !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
au VimLeave * silent! !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock'

" Toggle NerdTree
nnoremap <Leader>n :NERDTreeToggle<CR>

" Remap splits navigation to just Ctrl + hjkl
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Adjusing split sizes with Shift + hjkl
noremap <silent> <A-h> :vertical resize -5<CR>
noremap <silent> <A-j> :resize +5<CR>
noremap <silent> <A-k> :resize -5<CR>
noremap <silent> <A-l> :vertical resize +5<CR>

" Change 2 split windows from vert to horiz or horiz to vert
nnoremap <Leader>th <C-w>t<C-w>H
nnoremap <Leader>tv <C-w>t<C-w>K
nnoremap <C-w>a <C-w>v<C-w>t<C-w>K

" Coc autocomplete
inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "<Tab>"

" Indent/unindent with Tab/Shift-Tab
nmap <Tab> >>
nmap <S-tab> <<
imap <S-Tab> <Esc><<i
vmap <Tab> >gv
vmap <S-Tab> <gv

" Navigate between buffers (Emacs like)
nmap <leader>bp :bp<CR>
nmap <leader>bn :bn<CR>
nmap <leader>bk <C-w>cab> <gv

" Tagbar
map <leader>t :TagbarToggle<CR>

" Tabs
nnoremap <C-t> :tabnew<CR>
nnoremap <C-c> :tabclose<CR>
nnoremap <S-k> :tabnext<CR>
nnoremap <S-j> :tabprev<CR>
nnoremap <S-h> :tabfirst<CR>
nnoremap <S-l> :tablast<CR>

" Select all
nnoremap <C-a> gg<S-v><S-g>

" Comment
nnoremap <C-_> <Plug>CommentaryLinej

" Goyo
nnoremap <leader>g :Goyo<CR>

"#####################################################
"################         LETs        ################
"#####################################################

" Air-line
let g:airline_powerline_fonts = 1
let g:airline_theme = 'onedark'

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

"#####################################################
"################      AUTOCMDs       ################
"#####################################################

" Automatically deletes all trailing whitespace and newlines at end of file on save. & reset cursor position
autocmd BufWritePre * let currPos = getpos(".")
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre * %s/\n\+\%$//e
autocmd BufWritePre *.[ch] %s/\%$/\r/e
autocmd BufWritePre * cal cursor(currPos[1], currPos[2])

" Custom tabstop for html, css, javascript
autocmd FileType html setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType css setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2

" Restore place in file from previous session
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Disable Coc
autocmd BufReadPost * silent CocDisable

"#####################################################
"################      FUNCTIONS      ################
"#####################################################

" Wrap toggle
setlocal nowrap
noremap <silent> <Leader>w :call ToggleWrap()<CR>
function ToggleWrap()
    if &wrap
        echo "Wrap OFF"
        setlocal nowrap
        set virtualedit=all
        silent! nunmap <buffer> <Up>
        silent! nunmap <buffer> <Down>
        silent! nunmap <buffer> <Home>
        silent! nunmap <buffer> <End>
        silent! iunmap <buffer> <Up>
        silent! iunmap <buffer> <Down>
        silent! iunmap <buffer> <Home>
        silent! iunmap <buffer> <End>
    else
        echo "Wrap ON"
        setlocal wrap linebreak nolist
        set virtualedit=
        setlocal display+=lastline
        noremap  <buffer> <silent> <Up>   gk
        noremap  <buffer> <silent> <Down> gj
        noremap  <buffer> <silent> <Home> g<Home>
        noremap  <buffer> <silent> <End>  g<End>
        inoremap <buffer> <silent> <Up>   <C-o>gk
        inoremap <buffer> <silent> <Down> <C-o>gj
        inoremap <buffer> <silent> <Home> <C-o>g<Home>
        inoremap <buffer> <silent> <End>  <C-o>g<End>
    endif
endfunction

" Disable autoindent when pasting text
let &t_EI .= "\<Esc>[?2004l"

function! XTermPasteBegin()
    set pastetoggle=<Esc>[201~
    set paste
    return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

" Autoinstall Vim-Plug
if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif
