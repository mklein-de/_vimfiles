if exists("current_compiler")
  finish
endif
let current_compiler = "xa"

setlocal makeprg=xa\ %\ -o\ `basename\ %\ .a65`.o65
setlocal errorformat=%f:line\ %l:\ %*[0-9a-f]:%m
