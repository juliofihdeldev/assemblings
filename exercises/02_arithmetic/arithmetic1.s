// Arithmetic 1 - ADD and SUB
//
// Basic arithmetic instructions (all non-destructive to sources):
//
//   add x0, x1, x2      x0 = x1 + x2
//   add x0, x1, #5      x0 = x1 + 5    (immediate)
//   sub x0, x1, x2      x0 = x1 - x2
//   sub x0, x1, #3      x0 = x1 - 3
//
// The result always goes in the first (destination) operand.
// The source operands are NOT modified.
//
// YOUR TASK:
//   Compute (100 - 37) + 15 = 78. Exit with 78.
//   There is one buggy instruction — find and fix it.
//
// Expected exit code: 78

// I AM NOT DONE

.global _main
.align 2

_main:
    mov  x1, #100
    mov  x2, #37
    mov  x3, #15

    sub  x0, x1, x2      // x0 = 100 - 37 = 63  ✓
    add  x0, x0, x2      // BUG: adds x2 (37) instead of x3 (15)

    mov  x16, #1
    svc  #0x80
