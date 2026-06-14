// Arithmetic 2 - MUL (multiply)
//
//   mul x0, x1, x2    x0 = x1 * x2   (64-bit, lower 64 bits of result)
//   mul w0, w1, w2    x0 = w1 * w2   (32-bit)
//
// Unlike ADD/SUB, MUL cannot use an immediate as the third operand —
// both sources must be registers.
//
// If you need to multiply by a constant, load it into a register first:
//   mov x2, #7
//   mul x0, x1, x2    // x0 = x1 * 7
//
// YOUR TASK:
//   Compute 6 * 7 = 42. Exit with 42.
//   Fix the MUL instruction.
//
// Expected exit code: 42

// I AM NOT DONE

.global _main
.align 2

_main:
    mov  x1, #6
    mov  x2, #7

    mul  x0, x1, x1   // BUG: multiplies x1*x1 (=36) instead of x1*x2 (=42)

    mov  x16, #1
    svc  #0x80
