from std/os import getEnv, `/`

proc evalPath*(p: string; enclosed = "{}"): string =
  var
    inVar = false
    varName = ""
  for ch in p:
    if ch == enclosed[0]:
      inVar = true
      varName = ""
    elif ch == enclosed[1]:
      inVar = false
      result = result / getEnv varName
    else:
      if inVar:
        varName.add ch
      else:
        result.add ch
