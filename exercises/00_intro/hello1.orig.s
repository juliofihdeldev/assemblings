// Intro 1 - Hello, Assembly!
//
// Every ARM64 program needs an entry point labeled _main.
// This program uses macOS system calls (syscalls) to print text and exit.
//
// SYSCALL PATTERN:
//   x16  = syscall number
//   x0   = first argument
//   x1   = second argument
//   x2   = third argument
//   svc #0x80  = trigger the syscall
//
// SYSCALLS USED HERE:
//   write(fd, buf, len)  →  x16=4,  x0=fd(1=stdout), x1=address, x2=length
//   exit(code)           →  x16=1,  x0=exit code
//
// adr x1, label  →  loads the ADDRESS of 'label' into x1
// .ascii "..."   →  stores the bytes of the string at this location
//
// YOUR TASK:
//   The message below says "Hello, Assembler!" but it should say
//   "Hello, Assembly!". Fix the .ascii string.
//
// Expected output:
//   Hello, Assembly!

// I AM NOT DONE

.global _main
.align 2

_main:
    mov  x0, #1              // fd = stdout
    adr  x1, message         // buf = &message
    mov  x2, #17             // len = 17 bytes
    mov  x16, #4             // syscall: write
    svc  #0x80

    mov  x0, #0              // exit code 0
    mov  x16, #1             // syscall: exit
    svc  #0x80

message:
    .ascii "Hello, Assembler!\n"   // BUG: wrong word — fix it
