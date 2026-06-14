// Loops 2 - Multiplication via repeated addition
//
// Since MUL requires both sources in registers, here we practice
// an alternative: compute A*B by adding A to itself B times.
//
//   result = 0
//   counter = B
// loop:
//   result = result + A
//   counter = counter - 1
//   if counter > 0: goto loop
//
// This is also a useful pattern for any accumulation loop.
//
// YOUR TASK:
//   Compute 5 * 6 = 30 using repeated addition.
//   x0 = accumulator (result, starts at 0)
//   x1 = the value to add each iteration (5)
//   x2 = counter (6, counts how many times to add)
//
//   Fix the loop body: it's adding the COUNTER (x2) instead of
//   the multiplicand (x1).
//
// Expected exit code: 30

// I AM NOT DONE

.global _main
.align 2

_main:
    mov  x0, #0            // result = 0
    mov  x1, #5            // multiplicand
    mov  x2, #6            // counter

loop:
    add  x0, x0, x2        // BUG: adds counter (x2) instead of multiplicand (x1)
    sub  x2, x2, #1        // counter--
    cmp  x2, #0
    b.gt loop

    mov  x16, #1
    svc  #0x80
