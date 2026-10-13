# Assembly-Programming-Package-Mac

NASM + DOSBox + AFD setup for FAST-NUCES COAL, on Mac.

## Step 1: Get the files

**Option A — Download ZIP**
1. Click the green **Code** button at the top of this page
2. Click **Download ZIP**
3. Unzip it (double-click the downloaded file)
4. Open Terminal and type:
```bash
cd Downloads/Assembly-Programming-Package-Mac-main
```

**Option B — Clone with git**

Open Terminal and type:
```bash
git clone https://github.com/Hanbal-Kang/Assembly-Programming-Package-Mac.git
cd Assembly-Programming-Package-Mac
```

## Step 2: Install

In Terminal, type these two lines one at a time, pressing Enter after each:
```bash
chmod +x install.sh build.sh
./install.sh
```

Wait for it to finish. This installs NASM and DOSBox.

## Step 3: Where to write your code

Open the `examples` folder. Put your `.asm` files there. Use any text
editor (VS Code, Notepad, whatever).

**Filename rule:** max 8 characters, no spaces. Example: `hello.asm` ✅, `myfirstprogram.asm` ❌

## Step 4: Run your code

In Terminal, type (replace `hello` with your filename, no `.asm` at the end):
```bash
./build.sh hello
```

This assembles your code and opens DOSBox in the `examples` folder. You will see a DOS prompt (`C:\EXAMPLES>`). Now type one of these:

- `hello.com` — runs your program (use this to see screen / display memory output)
- `afd hello.com` — opens it in the AFD debugger

Want AFD to open straight away? Use:
```bash
./build.sh hello debug
```

**Inside AFD, press:**
- `G` — run the program
- `F2` — step one instruction at a time
- `F1` — step, skipping over `call` instructions
- `B <address>` — set a breakpoint

**Changed your code?** Close DOSBox and run `./build.sh hello` again from Terminal. DOSBox can't assemble, only Terminal can.

A `.lst` file is also created next to your `.asm`. It shows the address and bytes of every instruction.

## Test everything works

```bash
./build.sh hello
```
Then type `hello.com` at the DOS prompt. You should see the letter `B` on the third line of the screen.
