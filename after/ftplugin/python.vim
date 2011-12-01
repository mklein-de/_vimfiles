set sw=2 et

let b:highlight_space_errors = 1
silent call spaceerror#HLSpaceErr()

autocmd BufWritePre <buffer> 1,$s/\s\+$//e|call histdel("/",-1)
