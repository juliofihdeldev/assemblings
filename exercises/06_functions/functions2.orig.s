// Functions 2 - Arguments and the calling convention
//
// ARM64 uses the AAPCS64 calling convention:
//   Arguments:    x0, x1, x2, x3, x4, x5, x6, x7  (first 8 args)
//   Return value: x0
//   Caller-saved: x0-x18  (may be overwritten by the callee)
//   Callee-saved: x19-x28 (callee must restore these before returning)
//
// Example — calling a two-argument function:
//   mov  x0, #10        // first argument
//   mov  x1, #20        // second argument
//   bl   add_them       // call; result in x0
//
// add_them:
//   add  x0, x0, x1    // return x0+x1 in x0
//   ret
//
// YOUR TASK:
//   Call 'add_args' with 13 and 29. It should return 42.
//   The function body has a bug: it adds the wrong registers.
//   Fix the ADD inside 'add_args'.
//
// Expected exit code: 42

// I AM NOT DONE

.global _main
.align 2

_main:
    mov  x0, #13           // first argument
    mov  x1, #29           // second argument
    bl   add_args          // call; result in x0

    mov  x16, #1
    svc  #0x80

add_args:
    add  x0, x0, x0        // BUG: x0+x0 = 26 instead of x0+x1 = 42
    ret
