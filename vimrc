set nocompatible
filetype off " required during vundle initialization

" Vundle bootstrap
let s:vundle_path=expand('$HOME/.vim/bundle/Vundle.vim')
if !filereadable(s:vundle_path.'/.git/config') && confirm("Clone Vundle?","Y\nn") == 1
  exec '!git clone https://github.com/VundleVim/Vundle.vim '.s:vundle_path
endif
exec 'set runtimepath+='.s:vundle_path

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'Chiel92/vim-autoformat'
Plugin 'altercation/vim-colors-solarized'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'keith/swift.vim'
Plugin 'mileszs/ack.vim'
Plugin 'mtth/scratch.vim'
Plugin 'rosenfeld/conque-term'
Plugin 'scrooloose/nerdcommenter'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'
Plugin 'vim-jp/vim-cpp'
Plugin 'vim-scripts/Align'
Plugin 'vim-scripts/The-NERD-tree'
Plugin 'vim-scripts/a.vim'
Plugin 'vim-scripts/pydoc.vim'
Plugin 'vim-scripts/snipMate'
Plugin 'vim-scripts/taglist.vim'
Plugin 'yegappan/mru'

call vundle#end()

filetype plugin indent on

" misc stuff
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

set diffopt=filler,vertical

set titlestring=VIM\ -\ %t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)
if version >= 700 && !empty(glob(expand("<sfile>:p:h")."/bundle/vim-fugitive"))
  set statusline=%<%f\ [%{&fileencoding}%{fugitive#statusline()}%H%R%M]%=%b\ 0x%B\ \ %l,%c%V\ \ %{VimBuddy()}\ \ %P
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
  if &t_Co >= 256
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

let g:filetype_m = 'objc'

let lex_uses_cpp=1

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
nmap <silent> <F5> \c<space>j
vmap <silent> <F5> \c<space>

" Autoformat
nmap <C-k> :Autoformat<CR>
vmap <C-k> :Autoformat<CR>

nnoremap <Right> <C-w>l
nnoremap <Left>  <C-w>h
nnoremap <Up>    <C-w>k
nnoremap <Down>  <C-w>j

nmap <silent> <Leader><space> :call spaceerror#ToggleHLSpaceErr()<CR>
highlight link SpaceError SpellBad

" snipMate
let g:snips_author = 'Michael Klein'

" alternate
let g:alternateExtensions_m = "h"
let g:alternateExtensions_h = "c,cpp,cxx,cc,CC,m"

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

function SyntaxItem()
  return synIDattr(synID(line("."),col("."),1),"name")
endfun

autocmd BufNewFile * call TryAlternateFilenames()

" MRU
let g:MRU_Exclude_Files = '^/tmp/'

" ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

hi MatchParen cterm=bold term=bold ctermbg=NONE ctermfg=darkgray

autocmd BufNewFile,BufRead * let b:highlight_space_errors = 1
autocmd BufNewFile,BufRead * silent! call spaceerror#HLSpaceErr()
