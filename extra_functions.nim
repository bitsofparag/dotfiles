import
  os,
  osproc,
  posix,
  terminal

proc getNvm*(): string =
  let (o, err) = execCmdEx("nvm current")
  if err == 0:
    return o
  else:
    let (n, err) = execCmdEx("node --version")
    if err == 0:
       return n
    else:
      return ""