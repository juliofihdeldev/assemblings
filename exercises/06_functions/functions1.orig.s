// Functions 1 - BL and RET
//
// In ARM64, functions are called with BL (Branch with Link):
//   bl  my_function       // jump to my_function; save return address in x30
//
// Functions return with RET:
//   ret                   // jump to address in x30 (the saved return address)
//
// x30 is the Link Register (LR). BL automatically sets it.
// Without RET, the function will run off into whatever bytes follow it
// in memory — almost certainly a crash.
//
// The return VALUE goes in x0 (by convention).
//
// YOUR TASK:
//   'get_answer' should return 42 in x0.
//   The function body is correct, but it's missing its return instruction.
//   Add the missing instruction.
//
// Expected exit code: 42

// I AM NOT DONE

.global _main
.align 2

_main:
    bl   get_answer     // call get_answer; result lands in x0

    mov  x16, #1        // exit with whatever x0 holds
    svc  #0x80

get_answer:
    mov  x0, #42
    // TODO: add the instruction that returns to the caller
