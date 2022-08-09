when defined windows:
  const target_x64 = true # true = x64; false = x86

  from std/strutils import multiReplace;const configPath = r"C:\Program Files\Developer\nim-1.6.4\config\nim.cfg";const x64_conf = """gcc.path = r"C:\Program Files\Developer\mingw64\bin" # Compile x64""";const x86_conf = """gcc.path = r"C:\developer\MinGW\bin" # Compile x86""";when target_x64:configPath.writeFile configPath.readFile.multiReplace({"  # "&x64_conf:"  "&x64_conf,"  "&x86_conf:"  # "&x86_conf})else:  configPath.writeFile configPath.readFile.multiReplace({"  # "&x86_conf:"  "&x86_conf,"  "&x64_conf:"  # "&x64_conf});switch("cpu","i386");switch("passC","-m32");switch("passL","-m32")
