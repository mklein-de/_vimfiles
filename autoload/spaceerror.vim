if exists("g:spacerror_plugin_loaded")
  finish
endif
let g:spacerror_plugin_loaded = 1

function spaceerror#HLSpaceErr()
  if exists("b:highlight_space_errors") && b:highlight_space_errors!=0
    syn match SpaceError "\t\+" containedin=ALL
    syn match SpaceError "\s\+$" containedin=ALL
    echo "Space error display is ON"
  else
    syn clear SpaceError
    echo "Space error display is OFF"
  endif
endfun

function spaceerror#ToggleHLSpaceErr()
  if !exists("b:highlight_space_errors")
    let b:highlight_space_errors = 0
  endif
  let b:highlight_space_errors = 1 - (b:highlight_space_errors != 0)
  call spaceerror#HLSpaceErr()
endfun
