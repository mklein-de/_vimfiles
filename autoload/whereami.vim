function whereami#WhereAmI()
  if &cindent
    let curline = searchpair('{', '', '}', 'cbnW')
    if curline == 0
      return "(no scope)"
    endif
  else
    let curline = line(".")
  endif
  if !exists("b:last_change") || b:last_change != changenr()
    if &modified
      let file = tempname()
      silent exe ":w !cat > ".file
      let istmpfile = 1
    else
      let file = expand("%")
      let istmpfile = 0
    endif

    let cmdline = 'ctags -f - --fields=ks --excmd=num -u --language-force='
    if &filetype == 'cpp'
      let cmdline .= 'c++'
    else
      let cmdline .= &filetype
    endif
    if exists("b:whereami_ctags_opts")
      let cmdline .= " ".shellescape(b:whereami_ctags_opts)
    endif
    let cmdline .= " ".shellescape(file)

    let b:tags = []
    for l in split(system(cmdline), '\n')
      let a = split(l, '\t')
      if len(a) > 2
        let tag = a[0]
        if len(a) > 4
          let scope = substitute(a[4], '^[^:]*:', '', '')
          let scopes = split(scope, "::")
          if len(scopes) > 2
            call remove(scopes, -2, -1)
          endif
          let tag = join(scopes, "::")."::".tag
        endif
        if len(a) > 3
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
        endif
        call add(b:tags, [substitute(a[2], ';"', '', ''), tag])
      endif
    endfor
    if istmpfile
      call delete(file)
    endif
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
  if lb > 0 && b:tags[lb-1][0] < curline
    return b:tags[lb-1][1]
  endif
  return "(completely lost)"
endfun

au BufRead * unlet! b:last_change
