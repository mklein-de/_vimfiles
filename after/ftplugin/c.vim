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

  function s:HLSpaceErr()
    if b:highlight_space_errors!=0
      syn match cSpaceError display "\t\+"
      syn match cSpaceError display "\s\+$"
      echo "Space error display is ON"
    else
      syn clear cSpaceError
      echo "Space error display is OFF"
    endif
  endfun

  function s:ToggleHLSpaceErr()
    let b:highlight_space_errors = 1 - (b:highlight_space_errors != 0)
    call <SID>HLSpaceErr()
  endfun

endif

nmap <buffer> <silent> <LocalLeader># :call <SID>CppEndifCmt()<CR>
nmap <buffer> <silent> <LocalLeader><space> :call <SID>ToggleHLSpaceErr()<CR>

vmap <buffer> <silent> <LocalLeader># <esc>'<O#if 0<esc>'>o#endif<esc>0

set fo-=t fo+=croql
set cindent
set cino=(0
set comments=sr:/*,mbl2:*,ex:*/

set expandtab
set shiftwidth=4

syntax sync fromstart

highlight link cSpaceError SpellBad

let b:highlight_space_errors = 1
silent call <SID>HLSpaceErr()
