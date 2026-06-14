// Intro 2 - String lengths
//
// The write syscall needs to know exactly how many bytes to print:
//   write(fd=1, buf=&message, len=N)
//
// The length must match the actual number of bytes in your string.
// If len is too large, write prints garbage after the string.
// If len is too small, it truncates the output.
//
// Count bytes manually or use assembler arithmetic:
//   message:
//       .ascii "Assemblings!\n"
//   message_len = . - message     // '.' means current address
//                                 // so this computes length automatically
//
// YOUR TASK:
//   The message is "Assemblings!\n" (13 bytes), but the length
//   passed to write is wrong. Fix it.
//
// Expected output:
//   Assemblings!

// I AM NOT DONE

.global _main
.align 2

_main:
    mov  x0, #1
    adr  x1, message
    mov  x2, #99             // BUG: wrong length — how many bytes is "Assemblings!\n"?
    mov  x16, #4
    svc  #0x80

    mov  x0, #0
    mov  x16, #1
    svc  #0x80

message:
    .ascii "Assemblings!\n"
