// Loops 1 - Building loops with branches
//
// Loops are just backward branches with a condition.
// A typical countdown loop:
//
//   mov  x1, #5         // counter = 5
// loop:
//   // ... loop body ...
//   sub  x1, x1, #1    // counter--
//   cmp  x1, #0
//   b.gt loop           // repeat while counter > 0
//
// The loop runs while the condition stays true.
// When the condition fails, execution continues past the branch.
//
// YOUR TASK:
//   Sum the values 5+4+3+2+1 = 15 using a loop.
//   x0 = accumulator (starts at 0)
//   x1 = counter     (counts from 5 down to 1)
//
//   Fix the loop body: it should add the COUNTER value (x1) to the
//   accumulator each iteration, not a constant 1.
//
// Expected exit code: 15

// I AM NOT DONE

.global _main
.align 2

_main:
    mov  x0, #0            // accumulator = 0
    mov  x1, #5            // counter = 5

loop:
    add  x0, x0, #1        // BUG: adds 1 every iteration instead of the counter (x1)
    sub  x1, x1, #1        // counter--
    cmp  x1, #0
    b.gt loop               // repeat while counter > 0

    mov  x16, #1
    svc  #0x80
