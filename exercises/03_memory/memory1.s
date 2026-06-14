// Memory 1 - Loading values from labeled memory
//
// Data can be stored at named memory locations in the assembly file:
//
//   .align 3        // align to 8-byte boundary (required for .quad)
//   number: .quad 42    // store the 64-bit integer 42 at label 'number'
//
// To load it into a register (two-step process):
//
//   Step 1 — get the ADDRESS of the label:
//     adr  x1, number       // x1 = address of 'number'
//
//   Step 2 — dereference to get the VALUE:
//     ldr  x0, [x1]         // x0 = *(x1)  =  the value stored at x1
//
// You can also load from an offset:
//   ldr  x0, [x1, #8]       // x0 = *(x1 + 8)   (8 bytes past x1)
//
// YOUR TASK:
//   Load the value at 'first' (which is 77) into x0 and exit with it.
//   The data section has two consecutive 8-byte values: 77 and 99.
//   Fix the LDR instruction to load from the right address.
//
// Expected exit code: 77

// I AM NOT DONE

.global _main
.align 2

_main:
    adr  x1, first       // x1 = address of 'first'
    ldr  x0, [x1, #8]   // BUG: loads 8 bytes past 'first' (= 99, the second value)
                          //      Should load from [x1] (no offset) to get 77.

    mov  x16, #1
    svc  #0x80

.align 3
first:
    .quad 77              // 8 bytes at offset 0
second:
    .quad 99              // 8 bytes at offset 8
