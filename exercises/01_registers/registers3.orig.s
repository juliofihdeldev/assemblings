// Registers 3 - x (64-bit) vs w (32-bit) register names
//
// Every general-purpose register has two names:
//   xN   64-bit view  (full 8 bytes)
//   wN   32-bit view  (lower 4 bytes; writing wN zeros the upper 32 bits of xN)
//
// They refer to the same physical register:
//   mov w0, #7    // loads 7 into lower 32 bits; upper 32 bits become 0
//   mov x0, #7    // same effect for small numbers
//
// Use x-registers for: addresses, 64-bit values, syscall arguments
// Use w-registers for: 32-bit integers, when instructions require it
//
// ADD works with both:
//   add x0, x1, x2    // 64-bit addition
//   add w0, w1, w2    // 32-bit addition (result zero-extended to 64 bits)
//
// YOUR TASK:
//   x1 holds 10, x2 holds 15.
//   Add them and store the result in x0. Exit with the sum.
//
// Expected exit code: 25

// I AM NOT DONE

.global _main
.align 2

_main:
    mov  x1, #10
    mov  x2, #15

    add  x0, x1, x1   // BUG: adds x1+x1 (=20) instead of x1+x2 (=25)

    mov  x16, #1
    svc  #0x80
