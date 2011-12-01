if !exists("g:After_ftplugin_c_funcs_loaded")

  let g:After_ftplugin_c_funcs_loaded = 1

  function s:CppEndifCmt()
    let l:linenr = line(".")
    let l:line = getline(l:linenr)
    if match(l:line, '^\s*#\s*endif\>.*$') >= 0
      let l:line = substitute(l:line, '^\( *\)#\( *\)endif.*$', '\#\1\2endif', "")
      norm %
      let l:sym = matchstr(getline("."), "[A-Za-z_0-9]* *$")
      call setline(l:linenr, l:line . " /* " . l:sym . " */")
      norm 
    endif
  endfun
endif

nmap <buffer> <silent> <LocalLeader># :call <SID>CppEndifCmt()<CR>
vmap <buffer> <silent> <LocalLeader># <esc>'<O#if 0<esc>'>o#endif<esc>0

set fo-=t fo+=croql
set cindent
set cino=(0,:0,g0,t0
set comments=sr:/*,mbl2:*,ex:*/

set smarttab sw=4 ts=4 et

syntax sync minlines=2000

let b:highlight_space_errors = 1
silent call spaceerror#HLSpaceErr()

let b:whereami_ctags_opts = "--c-kinds=cfgmnsu"
