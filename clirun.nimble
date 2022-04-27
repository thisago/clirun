# Package

version       = "0.1.0"
author        = "Luciano Lorenzo"
description   = "A executable launcher that expects a CLI parameter to run the binary"
license       = "MIT"
srcDir        = "src"
bin           = @["clirun"]

binDir = "build"

# Dependencies

requires "nim >= 1.6.4"
requires "strenc"

from std/strformat import fmt, `&`

let i = paramCount()
const binDir = "build"
var defs = ""

echo i
if i == 10: defs = &"-d:secret=\"{paramstr(i-1)}\" -d:exe=\"{paramstr(i)}\""
if i == 11: defs = &"-d:secret=\"{paramstr(i-2)}\" -d:exe=\"{paramstr(i-1)}\" -d:output=\"{paramstr(i)}\""
if i == 12: defs = &"-d:secret=\"{paramstr(i-3)}\" -d:exe=\"{paramstr(i-2)}\" -d:output=\"{paramstr(i-1)}\" -d:cmd=\"{paramstr(i)}\""
echo defs

task buildRelease, "Builds the release version":
  exec fmt"nim c {defs} -d:danger --outDir:{binDir} src/clirun"
  exec "strip build/clirun"

task buildWinRelease, "Builds the windows release version":
  exec fmt"nim c -d:mingw {defs} -d:danger --outDir:{binDir} src/clirun"
  exec "strip build/clirun.exe"
