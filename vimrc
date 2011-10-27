call pathogen#infect()

set langmenu=en_US.UTF-8

set hlsearch
set nocompatible
set autowrite
set ignorecase
set smartcase
set incsearch
set visualbell
set showcmd
set scrolloff=3
set suffixes=.bak,.swp,.o
set modelines=5
set laststatus=2
set showbreak=>\ 
set showmatch
set autoindent
set wildignore=*.o,*~,*.orig
set title
set wildmenu
set isfname-==
set dir=/tmp,/var/tmp

if has("mouse")
  set mouse=n
endif

let c_syntax_for_h=1

" overridden by .gvimrc
if &term =~ "linux"
	set background=dark
endif

autocmd!

set printoptions=paper:A4
set backspace=indent,eol,start

if &diff
	nmap <silent> <Leader>p :diffput<CR>]c
	nmap <silent> <Leader>g :diffget<CR>]c
endif

filetype plugin indent on
autocmd BufRead /tmp/pico.* set nobackup filetype=mail
autocmd BufRead,BufNewFile *.a65 set ft=asm syntax=a6502
autocmd BufRead,BufNewFile *.mod,*.def set ft=modula2
autocmd BufRead,BufNewFile *.m set ft=objc
autocmd BufRead,BufNewFile Portfile set ft=portfile
autocmd BufRead passwords.asc set viminfo=|setlocal noswapfile|exe "silent 1,$!gpg -q --decrypt"|redraw!
autocmd BufWritePre passwords.asc 1,$!gpg -q --armor --encrypt --default-recipient-self
autocmd BufWritePost passwords.asc undo

nmap <silent> <Leader>w :set wrap! wrap?<CR>
nmap <silent> <Leader>h :set hlsearch! hlsearch?<CR>
nmap <silent> <Leader>n :set number! number?<CR>

autocmd GUIEnter * winsize 90 40

nmap <F3> zc
imap <F3> <C-o>zc
nmap <F4> zo
imap <F4> <C-o>zo
nmap <silent> <F5> :call ToggleCommentify('no')<CR>j
imap <silent> <F5> <C-O>:call ToggleCommentify('no')<CR><C-O>j

nmap <silent> <F9> :cwindow<CR>
imap <silent> <F9> <C-o>:cwindow<CR>
nmap <silent> <F10> :cp<CR>
imap <silent> <F10> <C-o>:cp<CR>
nmap <silent> <F11> :cn<CR>
imap <silent> <F11> <C-o>:cn<CR>
nmap <silent> <F12> :Make<CR>
imap <silent> <F12> <C-o>:Make<CR>

nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-h> <C-w>h
nmap <C-l> <C-w>l

map Y y$
map Q gq

runtime macros/matchit.vim
nmap <Leader>K :execute "Man " expand("<cword>")<CR>

autocmd BufWritePre,FileWritePre *.html exe "%g/^ *<!-- _DATE_ -->/s/^\\( *<!-- _DATE_ -->\\).*$/\\1" .  strftime("%a %b %d %T %Z %Y") . "/"
autocmd BufWritePre,FileWritePre *.sgml exe "%g/^ *<!-- _DATE_ --><date>/s+^\\( *<!-- _DATE_ --><date>\\).*$+\\1" .  strftime("%Y-%m-%d") . "+"

if version >= 700
  au WinEnter * set cul
  au WinLeave * set nocul
  au InsertEnter * hi CursorLine cterm=none ctermbg=lightred guibg=lightmagenta
  au InsertLeave * hi CursorLine cterm=none ctermbg=lightyellow guibg=yellow
  hi CursorLine cterm=none ctermbg=lightyellow guibg=yellow
  set cul
endif

highlight rightMargin none
highlight StatusLine ctermfg=white ctermbg=darkblue cterm=none
highlight StatusLineNC ctermfg=black ctermbg=darkgrey cterm=none
highlight Visual ctermbg=lightblue cterm=none
highlight Search cterm=none ctermbg=lightgreen guibg=green
highlight LineNr ctermfg=darkblue ctermbg=lightgray

" override bogus default mail highlighting
hi link mailQuoted2 type
hi link mailQuoted4 type
hi link mailQuoted6 type

command! Cfd lcd %:p:h
command! -nargs=* Make make <args> | cwindow 3

syntax on

"auto BufEnter * let &titlestring = "VIM: " . expand("%:p")
"set title titlestring=%<%F%=%l/%L-%P titlelen=70
set titlestring=VIM\ -\ %t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)

set statusline=%<%f\ [%{&fileencoding}%{fugitive#statusline()}%H%R%M]%=%b\ 0x%B\ \ %l,%c%V\ \ %{vimbuddy#VimBuddy()}\ \ %P
