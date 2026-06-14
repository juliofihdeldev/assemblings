// Branching 1 - CMP and conditional branches
//
// CMP compares two values by computing (src1 - src2) and setting flags:
//   N (negative), Z (zero), C (carry), V (overflow)
//
// Conditional branches test those flags:
//   b.eq label    branch if equal          (Z=1)
//   b.ne label    branch if not equal      (Z=0)
//   b.gt label    branch if greater than   (signed, Z=0 and N=V)
//   b.lt label    branch if less than      (signed, N≠V)
//   b.ge label    branch if ≥              (signed, N=V)
//   b.le label    branch if ≤             (signed, Z=1 or N≠V)
//   b   label     unconditional branch
//
// Pattern:
//   cmp  x0, x1         // compare x0 and x1
//   b.gt bigger_label   // jump if x0 > x1
//   // ... x0 <= x1 code ...
//   b    done
// bigger_label:
//   // ... x0 > x1 code ...
// done:
//
// YOUR TASK:
//   x1=10, x2=5. If x1 > x2, exit with 1. Otherwise exit with 0.
//   Since 10 > 5, the expected exit code is 1.
//   Fix the branch condition.
//
// Expected exit code: 1

// I AM NOT DONE

.global _main
.align 2

_main:
    mov  x1, #10
    mov  x2, #5

    cmp  x1, x2
    b.lt is_greater     // BUG: b.lt branches when x1 < x2 (not what we want)
                         //      We want to branch when x1 > x2.

    mov  x0, #0          // x1 <= x2 path
    b    done

is_greater:
    mov  x0, #1          // x1 > x2 path

done:
    mov  x16, #1
    svc  #0x80
