silent! call pathogen#infect()

" misc stuff
set nocompatible
set autowrite
set backspace=indent,eol,start
set isfname-==
set modelines=5
set scrolloff=3
set showbreak=>\ 
set showcmd
set showmatch
set suffixes=.bak,.swp,.o
set wildmenu wildignore=*.o,*~,*.orig wildmode=longest,list,full

syntax on

if has("gui_running")
  set visualbell
  if has("gui_mac")
    set guifont=DejaVuSansMono:h11
  else
    "set guifont=DejaVu\ Sans\ Mono\ 8
    set guifont=Source\ Code\ Pro\ 8
  endif

end

" autoindenting
set autoindent smartindent

" search stuff
set incsearch hlsearch ignorecase smartcase

" always display statusline
set laststatus=2
set title

set titlestring=VIM\ -\ %t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)
if version >= 700
  "set statusline=%<%f\ [%{&fileencoding}%H%R%M]%=%b\ 0x%B\ \ %l,%c%V\ \ %{VimBuddy()}\ \ %P
  set statusline=%<%f\ [%{&fileencoding}%{fugitive#statusline()}%H%R%M]%=%b\ 0x%B\ \ %l,%c%V\ \ %{VimBuddy()}\ \ %P
  "set statusline=%<%f\ [%{&fileencoding}%{fugitive#statusline()}%H%R%M]\ \ %.40{whereami#WhereAmI()}%=%b\ 0x%B\ \ %l,%c%V\ \ %{VimBuddy()}\ \ %P
else
  set statusline=%<%f\ [%{&fileencoding}%H%R%M]%=%b\ 0x%B\ \ %l,%c%V\ \ %{VimBuddy()}\ \ %P
endif

function UpdateColors()
  " cterm colors
  if &t_Co < 256
    highlight StatusLine   ctermfg=white ctermbg=blue cterm=none
    highlight StatusLineNC ctermfg=white ctermbg=black cterm=none
    highlight Visual       ctermbg=cyan  cterm=none
    highlight Search       ctermbg=green
    highlight LineNr       ctermfg=blue cterm=bold
  else
    highlight StatusLine   ctermfg=white ctermbg=darkblue ctermfg=white cterm=none
    highlight StatusLineNC ctermfg=black ctermbg=darkgrey ctermfg=lightgray cterm=none
    highlight Visual       ctermbg=lightblue
    highlight Search       ctermbg=lightgreen
    highlight LineNr       ctermfg=darkblue ctermbg=lightgray
  end

  " gui colors
  highlight StatusLine   guifg=white guibg=darkblue gui=none
  highlight StatusLineNC guifg=black guibg=darkgrey gui=none
  highlight Visual       guibg=lightblue
  highlight Search       guibg=lightgreen
  highlight LineNr       guifg=darkblue guibg=lightgray

  highlight CurrentWord  cterm=underline term=underline gui=underline
  highlight Error        ctermfg=red ctermbg=none cterm=bold,underline guifg=red guibg=NONE
  if version >= 700
    highlight Error      gui=undercurl
  end

  " cursorline and current word highlighting
  if &t_Co < 256
    au InsertEnter * hi CursorLine ctermbg=none   cterm=bold
    au InsertLeave * hi CursorLine ctermbg=yellow cterm=none
  else
    au InsertEnter * hi CursorLine ctermbg=lightred    cterm=none
    au InsertLeave * hi CursorLine ctermbg=lightyellow cterm=none
  end
  au InsertEnter * hi CursorLine guibg=lightred
  au InsertLeave * hi CursorLine guibg=yellow

  doautocmd InsertLeave
  doautocmd WinEnter
endfun

au VimEnter * call UpdateColors()

" current word highlighting
if version >= 700
  au CursorHold * call matchcurrentword#MatchCurrentWord()
  au WinEnter * set cul
  au WinLeave * set nocul
endif

filetype plugin indent on
let g:filetype_m = 'objc'

autocmd BufRead,BufNewFile Portfile set nomodeline ft=portfile
autocmd BufRead,BufNewFile *.a65 set ft=asm syntax=a6502
autocmd BufRead,BufNewFile *.mod,*.def set ft=modula2
autocmd BufRead,BufNewFile *.ui set sw=1 et

autocmd BufRead passwords.asc set viminfo=|setlocal noswapfile|exe "silent 1,$!gpg -q --decrypt"|redraw!
autocmd BufWritePre passwords.asc 1,$!gpg -q --armor --encrypt --default-recipient-self
autocmd BufWritePost passwords.asc undo

runtime macros/matchit.vim

" not really useful in original vi...
map Y y$
map Q gq

command! Lcd lcd %:p:h
command! Cd cd %:p:h

" global toggle maps
nmap <silent> <Leader>w :set wrap! wrap?<CR>
nmap <silent> <Leader>h :set hlsearch! hlsearch?<CR>
nmap <silent> <Leader>n :set number! number?<CR>
nmap <silent> <Leader>t :TlistToggle<CR>

" quickfix maps
if version >= 700
  autocmd QuickFixCmdPost make :cwindow
endif

nmap <silent> <F2> :echo whereami#WhereAmI()<CR>

nmap <silent> <F9>  :cl<CR>
nmap <silent> <F10> :cp<CR>
nmap <silent> <F11> :cn<CR>
nmap <silent> <F12> :make<CR>

" -> enhanced commentify
let g:EnhCommentifyBindInInsert = 'no'
nmap <silent> <F5> \c
vmap <silent> <F5> \c

nmap <silent> <Leader><space> :call spaceerror#ToggleHLSpaceErr()<CR>
highlight link SpaceError SpellBad

" snipMate
let g:snips_author = 'Michael Klein'

" alternate
let g:alternateExtensions_m = "h"
let g:alternateExtensions_h = "c,cpp,cxx,cc,CC,m"

" legacy
autocmd BufWritePre,FileWritePre *.html exe "%g/^ *<!-- _DATE_ -->/s/^\\( *<!-- _DATE_ -->\\).*$/\\1" .  strftime("%a %b %d %T %Z %Y") . "/"
autocmd BufWritePre,FileWritePre *.sgml exe "%g/^ *<!-- _DATE_ --><date>/s+^\\( *<!-- _DATE_ --><date>\\).*$+\\1" .  strftime("%Y-%m-%d") . "+"

" handle foo.c:123
function TryAlternateFilenames()
  let fname = expand("%")
  let lastcolon = strridx(fname, ":")
  if lastcolon > 0
    let f = fname[0:lastcolon-1]
    let n = fname[lastcolon+1:-1]
    if filereadable(f) && match(n, '^[0-9]\+$') >= 0
      exe ':e +'.n.' '.escape(f, ' ').'|bd #'
    endif
  endif
endfun

autocmd BufNewFile * call TryAlternateFilenames()

hi MatchParen cterm=bold term=bold ctermbg=NONE ctermfg=darkgray
