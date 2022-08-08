# Package

version       = "0.3.0"
author        = "Thiago Navarro"
description   = "A executable launcher that encrypts a binary and expects a secret param to run the binary"
license       = "MIT"
srcDir        = "src"
bin           = @["clirun"]

binDir = "build"

# Dependencies

requires "nim >= 1.6.4"
requires "strenc"
requires "util"

from std/strformat import fmt, `&`

let paramsCount = paramCount()
const binDir = "build"
var defs = &"-d:conf=\"{paramstr(paramsCount)}\""

task buildRelease, "Builds the release version":
  exec fmt"nim c {defs} -d:danger --opt:speed --outDir:{binDir} src/clirun"
  exec "strip build/clirun"

task buildWinRelease, "Builds the windows release version":
  exec fmt"nim c -d:mingw {defs} -d:danger --opt:speed --outDir:{binDir} src/clirun.nim"
  exec "strip build/clirun.exe"
