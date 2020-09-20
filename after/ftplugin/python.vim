set sw=4 et ts=4

autocmd BufWritePre <buffer> 1,$s/\s\+$//e|call histdel("/",-1)

setlocal makeprg=pylint\ %
