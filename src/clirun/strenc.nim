# Source https://github.com/Yardanico/nim-strenc/blob/master/src/strenc.nim 
import hashes

type
  # Use a distinct string type so we won't recurse forever
  estring = distinct string

# Use a "strange" name
proc gkkaekgaEE(s: estring, key: int): string {.noinline.} =
  # We need {.noinline.} here because otherwise C compiler
  # aggresively inlines this procedure for EACH string which results
  # in more assembly instructions
  var k = key
  result = string(s)
  for i in 0 ..< result.len:
    for f in [0, 8, 16, 24]:
      result[i] = chr(uint8(result[i]) xor uint8((k shr f) and 0xFF))
    k = k +% 1

var encodedCounter {.compileTime.} = hash(CompileTime & CompileDate) and 0x7FFFFFFF

proc encode*(data: string): string =
  gkkaekgaEE(estring(data), encodedCounter)

template decode*(data: string): string =
  encode(data)
