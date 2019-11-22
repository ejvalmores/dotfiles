source ~/.vim/plugins.vim

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

set bg=dark
set t_Co=256
colorscheme gotham

"turning this on makes things slow sometimes, so provide a mapping to toggle it
set cursorline
nnoremap <Leader>l :set cursorline!<CR>

set hlsearch
nnoremap <leader>h :set hlsearch!<cr>

"reload
nnoremap <leader>r :windo :e %<cr>

"turn off the bell
set visualbell
set t_vb=

set ignorecase
set smartcase
set magic

set winwidth=120
set splitright

nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" ================ General Config ====================

set number "Line numbers are good
set backspace=indent,eol,start "Allow backspace in insert mode
set history=1000 "Store lots of :cmdline history
set showcmd "Show incomplete cmds down the bottom
set showmode "Show current mode down the bottom
set gcr=a:blinkon0 "Disable cursor blink
set autoread "Reload files changed outside vim

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

"turn on syntax highlighting
syntax on

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.

silent !mkdir ~/.vim/undo > /dev/null 2>&1
set undodir=~/.vim/undo
set undofile
set backupdir=~/.vim/backups
set dir=~/.vimr/swap


set statusline=%<%f%{fugitive#statusline()}\ %h%m%r%=%-14.(%l,%c%V%)\ %P

" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab


"maps
map <C-Right> :tabn<cr>
map <C-Left> :tabp<cr>

nmap Q <Nop>

filetype plugin on
filetype indent on


"leader key for plugins
let mapleader = "\\"

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

set nowrap "Don't wrap lines
set linebreak "Wrap lines at convenient points

" ================ Folds ============================

set foldmethod=indent "fold based on indent
set foldnestmax=3 "deepest fold is 3 levels
set nofoldenable "dont fold by default

" ================ Completion =======================

set wildmode=list:longest
set wildmenu "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif


" ================ Scrolling ========================

set scrolloff=8 "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

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
" nnoremap <leader>f :call SelectaCommand("find * -type f", "", ":vsplit")<cr>
nnoremap <leader>f :call SelectaCommand("git ls-files -co --exclude-standard", "", ":vsplit")

" Use ag the_silver_searcher instead of Ack
let g:ackprg = 'ag --nogroup --nocolor --column'
