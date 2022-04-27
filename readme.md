# Clirun

A secure way to run a program

## Usage

Compile with

```bash
nimble build_release \
  "secret" \ # Secret argument to give in terminal
  "/data/os/dev/nim/gui/secureDownloader/build/secureDownloader" \ # Binary path
  "{HOME}/Desktop/out.mp4" \ # The output location of binary after decrypting
  "bash -c 'chmod +x ./out.mp4 && ./out.mp4 secret'" # The command to execute
```
<section><details><pre><code>
nimble build_release "secret" "/data/os/dev/nim/gui/secureDownloader/build/secureDownloader" "{HOME}/Desktop/out.mp4" "bash -c 'chmod +x ./out.mp4 && ./out.mp4 secret'"
</code></pre></details></section>

And run with

```bash
./build/clirun secret
```
