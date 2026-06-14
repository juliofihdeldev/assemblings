// Branching 2 - Multi-way branches
//
// Chain multiple CMP+branch pairs to implement if/elif/else:
//
//   cmp  x0, #1
//   b.eq case1
//   cmp  x0, #2
//   b.eq case2
//   // falls through to default
//   b    done
// case1:
//   ...
//   b done
// case2:
//   ...
// done:
//
// Each CMP is independent and overwrites the flags from the previous one.
// So you must branch immediately after each CMP before the next one.
//
// YOUR TASK:
//   x0 = 3. Exit with 30 if x0==3, 20 if x0==2, 10 if x0==1, 0 otherwise.
//   One of the CMP values is wrong. Find and fix it.
//
// Expected exit code: 30

// I AM NOT DONE

.global _main
.align 2

_main:
    mov  x0, #3

    cmp  x0, #1
    b.eq case1

    cmp  x0, #2
    b.eq case2

    cmp  x0, #4       // BUG: compares with 4 instead of 3
    b.eq case3

    mov  x0, #0        // default
    b    done

case1:
    mov  x0, #10
    b    done

case2:
    mov  x0, #20
    b    done

case3:
    mov  x0, #30

done:
    mov  x16, #1
    svc  #0x80
