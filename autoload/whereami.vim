function whereami#WhereAmI()
  if &cindent
    let curline = searchpair('{', '', '}', 'cbnW')
    if curline == 0
      return "(completely lost)"
    endif
  else
    let curline = line(".")
  endif
  if !exists("b:last_change") || b:last_change != changenr()
    let tmpfile = tempname()
    exe 'silent w ' . tmpfile
    if &filetype == 'cpp'
      let ctags_type = 'c++'
    else
      let ctags_type = &filetype
    endif
    let cmdline = 'ctags -f - --c++-kinds=cfgnsu --fields=ks --excmd=num -u --language-force='.ctags_type.' "'.tmpfile.'"'
    let b:tags = []
    for l in split(system(cmdline), '\n')
      let a = split(l, '\t')
      let tag = a[0]
      if len(a) > 4
        let scope = substitute(a[4], '^[^:]*:', '', '')
        let scopes = split(scope, "::")
        if len(scopes) > 2
          call remove(scopes, -2, -1)
        endif
        let tag = join(scopes, "::")."::".tag
      endif
      let kind = a[3]
      if kind == 'c'
        let tag = "class ".tag
      elseif kind == 'f'
         let tag = tag."()"
      elseif kind == 'm'
      elseif kind == 'g'
        let tag = "enum ".tag
      elseif kind == 'n'
        let tag = "namespace ".tag
      elseif kind == 's'
        let tag = "struct ".tag
      elseif kind == 'u'
        let tag = "union ".tag
      else
        throw 'unhandled kind: ' . kind
      endif
      call add(b:tags, [substitute(a[2], ';"', '', ''), tag])
    endfor
    call delete(tmpfile)
    let b:last_change = changenr()
  endif
  let lb = 0
  let ub = len(b:tags)
  while ub > lb
    let tagnum = (lb + ub) / 2
    let tagline = b:tags[tagnum][0]
    if tagline == curline
      return b:tags[tagnum][1]
    else
      if tagline < curline
        let lb = tagnum + 1
      else
        let ub = tagnum
      endif
    endif
  endwhile
  let tagline = b:tags[lb-1][0]
  if tagline < curline
    return b:tags[lb-1][1]
  else
    return "(completely lost)"
  endif
endfun

au BufRead * unlet! b:last_change
