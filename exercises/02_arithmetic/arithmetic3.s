// Arithmetic 3 - Bit shifts
//
// Shifting bits left or right is equivalent to multiplying/dividing by powers of 2.
//
//   lsl x0, x1, #n    Logical Shift Left:  x0 = x1 * 2^n
//   lsr x0, x1, #n    Logical Shift Right: x0 = x1 / 2^n  (unsigned)
//   asr x0, x1, #n    Arithmetic Shift Right: x0 = x1 / 2^n (signed, preserves sign)
//
// Examples:
//   lsl x0, x1, #1    // x0 = x1 * 2
//   lsl x0, x1, #3    // x0 = x1 * 8
//   lsr x0, x1, #2    // x0 = x1 / 4
//
// Powers of 2:  2^1=2  2^2=4  2^3=8  2^4=16  2^5=32
//
// Shifts are very fast because they map directly to a single hardware instruction.
//
// YOUR TASK:
//   Compute 3 << 4  (3 * 2^4 = 3 * 16 = 48).
//   Fix the shift amount.
//
// Expected exit code: 48

// I AM NOT DONE

.global _main
.align 2

_main:
    mov  x1, #3

    lsl  x0, x1, #2   // BUG: shifts by 2 (3*4=12) instead of 4 (3*16=48)

    mov  x16, #1
    svc  #0x80
