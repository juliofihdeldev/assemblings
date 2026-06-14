// Memory 2 - The stack (STR and LDR)
//
// The stack is a region of memory that grows downward. The stack pointer
// register (sp) always points to the top of the stack.
//
// STORE to stack (make room first, then write):
//   sub  sp, sp, #16      // grow stack by 16 bytes (must stay 16-byte aligned)
//   str  x0, [sp]         // store x0 at address sp+0
//   str  x1, [sp, #8]     // store x1 at address sp+8
//
// LOAD from stack (read, then shrink):
//   ldr  x0, [sp]         // load from sp+0 into x0
//   ldr  x1, [sp, #8]     // load from sp+8 into x1
//   add  sp, sp, #16      // shrink stack by 16 bytes
//
// The stack is used to save registers across operations.
//
// YOUR TASK:
//   The value 123 is in x1. Save it to the stack, overwrite x1 with 0,
//   then restore the original value from the stack into x0. Exit with 123.
//   Fix the LDR instruction that loads the saved value back.
//
// Expected exit code: 123

// I AM NOT DONE

.global _main
.align 2

_main:
    mov  x1, #123

    sub  sp, sp, #16       // allocate 16 bytes on stack
    str  x1, [sp]          // save 123 at [sp+0]

    mov  x1, #0            // overwrite x1 (simulating other work)

    ldr  x0, [sp, #8]      // BUG: loads from [sp+8] which is uninitialized!
                            //      Should load from [sp] where we stored 123.
    add  sp, sp, #16       // restore stack pointer

    mov  x16, #1
    svc  #0x80
