import
  nicypkg/functions,
  strformat

export
  functions

when isMainModule:
  let
    prompt = color("› ", "magenta")
    nl = "\n"
    gitBranch = color(gitBranch(), "yellow")
    cwd = color(tilde(getCwd()), "cyan")
    dirty = color("×", "red")
    clean = color("•", "green")
    venv = color(virtualenv(), "magenta")
    node = color(getNvm(), "magenta")
  let git = gitBranch & gitStatus(dirty, clean)

  # the prompt
  echo fmt"{nl}{venv}{node}{cwd}{git}{nl}{prompt}"
