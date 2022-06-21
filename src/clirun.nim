from std/os import fileExists, commandLineParams, parentDir
from std/json import parseJson, `{}`, getStr, items

from std/strutils import join
from std/osproc import execCmd

from clirun/utils import evalPath

const debugging = false

when not debugging:
  from clirun/strenc import encode, decode
else:
  template encode(s: string): string = s
  template decode(s: string): string = s

type
  Config = object
    secret, fileData, destination: string
    commands: seq[string]

proc getConfig(json: string): Config =
  let
    node = parseJson json
    filePath = node{"file"}.getStr

  result = Config(
    secret: encode node{"secret"}.getStr,
    fileData: encode readFile filePath,
    destination: encode node{"destination"}.getStr,
  )
  for command in node{"commands"}:
    result.commands.add encode command.getStr

const conf {.strdefine.} = ""
when conf.len == 0:
  {.fatal: "Please provide config path with `-d:conf=/path/to/conf.json`".} 

when isMainModule:
  static: echo "Encoding the binary"
  const config = getConfig staticRead conf
  static: echo "Successfully encoded " & $config.fileData.len & " bytes" # TODO THIS and copu theses files and add a option to disable encoding

  let param = commandLineParams().join " "

  if param == config.secret.decode:
    var filename = evalPath decode config.destination
    writeFile filename, decode config.fileData
    for cmd in config.commands:
      let code = execCmd(decode cmd)
      if code != 0:
        quit code
