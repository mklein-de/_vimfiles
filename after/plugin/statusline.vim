if exists("*fugitive#statusline")
  let statusline_gitbranch='\ %{fugitive#statusline()}'
else
  let statusline_gitbranch=''
endif

if exists("*VimBuddy")
  let statusline_vimbuddy='\ \ %{VimBuddy()}'
else
  let statusline_vimbuddy=''
endif

if exists("*CFuncOfs")
  let statusline_cfunc='\ \ %{CFuncOfs()}'
else
  let statusline_cfunc=''
endif

exe 'set statusline=%<%f%h%m%r'. statusline_cfunc . statusline_gitbranch . '%=%b\ 0x%B\ \ %l,%c%V' . statusline_vimbuddy . '\ \ %P'
, 
