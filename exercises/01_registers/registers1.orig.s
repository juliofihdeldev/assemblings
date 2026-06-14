// Registers 1 - MOV with immediate values
//
// ARM64 has 31 general-purpose registers: x0 through x30.
//   x0-x7    arguments and return values
//   x8-x15   temporary registers
//   x16-x17  used for syscalls and linker stubs
//   x19-x28  callee-saved registers
//   x29      frame pointer
//   x30      link register (return address)
//   xzr      always-zero register (reads 0, writes are discarded)
//
// Each xN register also has a 32-bit alias wN (the lower half).
//
// MOV with an immediate value:
//   mov x0, #42     // load the number 42 into register x0
//   mov w0, #42     // same, using the 32-bit alias
//
// The exit syscall reads the exit code from x0.
// The test will check the process exit code.
//
// YOUR TASK:
//   Load the value 42 into x0 so the program exits with code 42.
//   Fix the MOV instruction below.
//
// Expected exit code: 42

// I AM NOT DONE

.global _main
.align 2

_main:
    mov  x0, #0        // BUG: loads 0 instead of 42

    mov  x16, #1       // syscall: exit
    svc  #0x80
