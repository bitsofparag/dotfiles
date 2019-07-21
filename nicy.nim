import
  nicypkg/functions,
  extra_functions,
  strutils,
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
    venv = color(virtualenv().strip, "magenta")
    node = color(getNvm().strip, "magenta")
  let git = gitBranch & gitStatus(dirty, clean)

  # the prompt
  echo fmt"{nl}({node} {venv}) {cwd}{git}{nl}{prompt}"
