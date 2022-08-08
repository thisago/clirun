from std/os import getEnv, `/`
from std/sugar import `=>`

from pkg/util/forStr import initVarParser, parseStr

proc parseVars*(text: string): string =
  let parsers = [initVarParser("{}", (k: string) => getEnv(k))]
  var oldRes = ""
  result = text
  while result != oldRes:
    oldRes = result
    result = result.parseStr parsers
