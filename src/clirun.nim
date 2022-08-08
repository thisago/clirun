from std/os import fileExists, commandLineParams, parentDir
from std/json import parseJson, `{}`, getStr, items, keys
from std/tables import Table, `[]`, `[]=`, `$`, pairs

from std/strutils import join
from std/osproc import execCmd

from clirun/utils import parseVars

const debugging = false

when not debugging:
  from clirun/strenc import encode, decode
else:
  template encode(s: string): string = s
  template decode(s: string): string = s

type
  Config = object
    secret: string
    files: Table[string, string]
    commands: seq[string]

proc getConfig(json: string): Config =
  let node = parseJson json

  result = Config(
    secret: encode node{"secret"}.getStr,
  )
  for file in node{"files"}.keys:
    let dest = encode node{"files", file}.getStr
    echo "Encoding " & file
    result.files[dest] = encode readFile file
    echo "Successfully encoded " & $result.files[dest].len & " bytes" # TODO THIS and copu theses files and add a option to disable encoding

  for command in node{"commands"}:
    result.commands.add encode command.getStr

const conf {.strdefine.} = ""
when conf.len == 0:
  {.fatal: "Please provide config path with `-d:conf=/path/to/conf.json`".} 

when isMainModule:
  const config = getConfig staticRead conf

  let param = commandLineParams().join " "

  if param == config.secret.decode:
    for dest, data in config.files:
      dest.decode.parseVars.writeFile decode data
    for cmd in config.commands:
      let code = execCmd(parseVars decode cmd)
      if code != 0:
        quit code
