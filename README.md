# Assemblings

Learn ARM64 Assembly by fixing small, broken programs — inspired by [Rustlings](https://rustlings.rust-lang.org/).

Each exercise is a `.s` assembly file with an intentional bug. You find it, fix it, save the file, and move on.

> **Architecture**: ARM64 (AArch64) — native on Apple Silicon Macs (M1/M2/M3/M4).
> The concepts (registers, arithmetic, memory, branching, loops, functions) map directly
> to the x86 assembly covered in tutorials like [tutorialspoint.com/assembly_programming](https://www.tutorialspoint.com/assembly_programming), just with different syntax.

## Requirements

- Apple Silicon Mac (M1 or later)
- Xcode Command Line Tools: `xcode-select --install`

## Getting Started

```bash
git clone <repo-url> assemblings
cd assemblings
bash install.sh
source ~/.zshrc

assemblings         # see your current exercise
```

## Workflow

```bash
assemblings watch   # recommended: auto-compiles and verifies on every save
```

Open the current exercise in your editor, fix the bug, save. The watcher compiles your code and tells you if you passed.

## Commands

| Command | Description |
|---|---|
| `assemblings` | Show current exercise and progress |
| `assemblings watch` | Auto-compile and verify on file save |
| `assemblings verify [name]` | Verify current or named exercise |
| `assemblings hint [name]` | Show a hint |
| `assemblings list` | List all exercises with status |
| `assemblings run [name]` | Compile and run without verifying |
| `assemblings reset <name>` | Reset exercise to original broken state |

## Exercise Format

Each exercise has two markers:

**`// I AM NOT DONE`** — remove this line when you're ready to be verified.

**`// BUG:`** or **`// TODO:`** comments — show you exactly what needs fixing.

```asm
// I AM NOT DONE

.global _main
.align 2

_main:
    mov  x0, #0       // BUG: should exit with 42
    mov  x16, #1
    svc  #0x80
```

## Topics Covered

```
00_intro        — program structure, write syscall, string lengths
01_registers    — MOV, register names (x0-x30, w0-w30), ADD
02_arithmetic   — ADD, SUB, MUL, LSL/LSR (bit shifts)
03_memory       — LDR/STR, data labels (.quad), the stack
04_branching    — CMP, conditional branches (b.eq, b.gt, b.lt, ...)
05_loops        — building loops with backward branches
06_functions    — BL/RET, calling convention, arguments in x0/x1
```

## ARM64 Quick Reference

```asm
// Move
mov  x0, #42          // x0 = 42  (immediate)
mov  x0, x1           // x0 = x1  (register copy)

// Arithmetic
add  x0, x1, x2       // x0 = x1 + x2
sub  x0, x1, x2       // x0 = x1 - x2
mul  x0, x1, x2       // x0 = x1 * x2
lsl  x0, x1, #3       // x0 = x1 << 3  (x1 * 8)
lsr  x0, x1, #2       // x0 = x1 >> 2  (x1 / 4)

// Memory
adr  x1, label        // x1 = address of label
ldr  x0, [x1]         // x0 = *x1
str  x0, [x1]         // *x1 = x0
ldr  x0, [x1, #8]     // x0 = *(x1 + 8)

// Branching
cmp  x0, x1           // set flags based on x0 - x1
b.eq label            // branch if equal
b.ne label            // branch if not equal
b.gt label            // branch if x0 > x1 (signed)
b.lt label            // branch if x0 < x1 (signed)
b    label            // unconditional branch

// Functions
bl   my_func          // call my_func (saves return addr in x30)
ret                   // return to caller (jumps to x30)

// macOS syscalls
mov  x16, #4          // write(fd, buf, len)
svc  #0x80
mov  x16, #1          // exit(code)
svc  #0x80
```

## Progress

Progress is stored in `.progress` in the repo directory. To start over:

```bash
rm .progress
```
