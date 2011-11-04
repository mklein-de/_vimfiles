set et tw=80
set iskeyword+=.
set iskeyword+=-

if !exists("g:did_load_portfile_functions")

  function s:Trim(arg)
    return substitute(a:arg, '^\s\+\|\s\+$\|\s*\\$', '', 'g')
  endfun

  function s:TrimL(arg)
    return substitute(a:arg, '^\s\+', '', '')
  endfun

  function s:TrimR(arg)
    return substitute(a:arg, '\s\+$\|\s*\\$', '', 'g')
  endfun

  function! Wrap(lnum, count)
    " doesn't support auto-wrap yet...
    if &tw == 0 || mode() == "i"  || mode() == "R"
      return
    end

    " join whole range
    let l:lines = []
    if a:count > 1
      let l:lines = getline(a:lnum, a:lnum + a:count - 1)
      let l:lines[0] = s:TrimR(l:lines[0])
      for l:i in range(1, len(l:lines)-2)
        let l:lines[l:i] = s:Trim(l:lines[l:i])
      endfor
      let l:lines[-1] = s:TrimL(l:lines[-1])
    else
      call add(l:lines, getline(a:lnum))
    endif
    let l:line = join(l:lines)

    let l:out = []
    let l:indent = matchstr(l:lines[0], '^\s*')

    while len(l:line) + len(l:indent) > &tw
      " should break line
      let l:wrappos = 0
      for l:i in range(len(l:indent), strlen(l:line))
        if l:line[l:i] =~ '\s'
          let l:wrappos = l:i
        endif
        if l:wrappos != 0 && l:i > &tw - &sw - len(' \')
          break
        endif
      endfor
      if l:wrappos != 0
        " found a wrap position
        call add(l:out, l:indent . s:Trim(l:line[0 : l:wrappos-1]) . ' \')
        let l:line = l:indent . s:TrimL(l:line[l:wrappos : -1])
      else
        " give up
        break
      endif
      if len(l:indent) != &sw
        let l:indent = printf('%*s', &sw, '')
      endif
    endwhile

    call add(l:out, l:indent . s:TrimL(l:line))

    if len(l:out) != a:count
      exe printf("%d,%dd", a:lnum, a:lnum + a:count - 1)
      call append(a:lnum - 1, l:out)
    else
      call setline(a:lnum, l:out)
    endif
  endfun

  let g:did_load_portfile_functions = 1

endif

setlocal formatexpr=Wrap(v:lnum,v:count)
setlocal formatoptions-=t
setlocal formatoptions+=l
