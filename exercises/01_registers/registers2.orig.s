// Registers 2 - Moving between registers
//
// MOV can copy the value of one register into another:
//   mov x0, x1     // x0 = x1  (copies x1's value into x0)
//   mov x1, x2     // x1 = x2
//
// This is non-destructive: the source register keeps its value.
//
// YOUR TASK:
//   The value 99 is placed into x1.
//   Copy it into x0 so the program exits with code 99.
//   Fix the MOV instruction that copies between registers.
//
// Expected exit code: 99

// I AM NOT DONE

.global _main
.align 2

_main:
    mov  x1, #99       // load 99 into x1

    mov  x0, x0        // BUG: copies x0 into x0 (does nothing!)
                       //      Should copy x1 into x0.

    mov  x16, #1
    svc  #0x80
