from std/os import fileExists, commandLineParams, parentDir

from std/strutils import join
from std/osproc import execProcess

from clirun/utils import evalPath

const debugging = false

when not debugging:
  from clirun/strenc import encode, decode
else:
  template encode(s: string): string = s
  template decode(s: string): string = s

const
  exe {.strdefine.} = ""
  secret {.strdefine.} = ""
  output {.strdefine.} = "{HOME}/Desktop/out.mp4"
  cmd {.strdefine.} = ""

  secretPass = encode secret
  outFilename = encode output
  command = encode cmd

when exe.len == 0: {.fatal: "Provide the path of binary".}
when secret.len == 0: {.fatal: "Provide the secret".}
when not fileExists exe: {.fatal: "File not exists".}

when isMainModule:
  static: echo "Encoding the binary " & exe
  const exeData = encode readFile exe
  static: echo "Successfully encoded " & $exeData.len & " bytes" # TODO THIS and copu theses files and add a option to disable encoding

  let param = commandLineParams().join " "

  if param == secretPass.decode:
    var filename = evalPath decode outFilename
    writeFile filename, decode exeData
    if command.len > 0:
      echo execProcess(decode command, filename.parentDir)
