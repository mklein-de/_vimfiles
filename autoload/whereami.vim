function whereami#WhereAmI()
  if &filetype == 'cpp' || &filetype == 'c'
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
    let output = system('ctags -x -u --language-force='.ctags_type.' "'.tmpfile.'"')
    call delete(tmpfile)
    let b:tags = split(output, '\n')
    let b:last_change = changenr()
  endif
  let lb = 0
  let ub = len(b:tags)
  while ub > lb
    let tagnum = (lb + ub) / 2
    let tag = split(b:tags[tagnum], '\s\+')
    let tagline = tag[2]
    if tagline == curline
      let lb = tagnum + 1
      return join(tag[4:], " ")
    else
      if tagline < curline
        let lb = tagnum + 1
      else
        let ub = tagnum
      endif
    endif
  endwhile
  return join(split(b:tags[lb-1], '\s\+')[4:], " ")
endfun
