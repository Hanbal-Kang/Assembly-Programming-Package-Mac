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

This assembles your code and opens DOSBox with the AFD debugger.

**Inside AFD, press:**
- `G` — run the program
- `F2` — step one instruction at a time
- `F1` — step, skipping over `call` instructions
- `B <address>` — set a breakpoint

## Test everything works

Run the sample file first:
```bash
./build.sh hello
```
Press `G`. You should see the letter `B` appear on screen.
