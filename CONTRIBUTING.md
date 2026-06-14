# Contributing to Assemblings

## Project Structure

```
assemblings/
├── assemblings                   # Main CLI (bash)
├── install.sh
├── README.md
├── CONTRIBUTING.md
└── exercises/
    ├── 00_intro/
    │   ├── hello1.s              # The file learners edit
    │   ├── hello1.orig.s         # Original broken state (used by 'reset')
    │   ├── .hello1.hint          # Hint text
    │   └── .hello1.test.sh       # Test script
    └── ...
```

Exercise files end in `.s` (ARM64 assembly source). Tests and hints are hidden files (`.name.test.sh`, `.name.hint`).

## Adding a New Exercise

### 1. Pick a topic directory (or create a new numbered one)

```
exercises/07_my_topic/
```

### 2. Write the exercise file

Name it `<topic><N>.s`. This is the file learners edit.

**Required elements:**
- A `// I AM NOT DONE` comment (the guard — learner removes this when ready)
- `.global _main` and `.align 2` entry point
- A clear comment header: concept explanation, syntax examples, expected output/exit code
- A `// BUG:` comment on the broken line, or `// TODO:` where code must be added
- ONE clear thing to fix per exercise

**Template:**
```asm
// Topic N - Short title
//
// Explanation of the concept with examples.
//
//   instruction operands     // => effect
//
// YOUR TASK:
//   What the learner must do.
//   Expected exit code: N   (or: Expected output: "...")

// I AM NOT DONE

.global _main
.align 2

_main:
    mov  x0, #0        // BUG: describe the bug
    mov  x16, #1
    svc  #0x80
```

### 3. Write the test script

Name it `.<exercise>.test.sh` (hidden). It receives the exercise path as `$1`.

**Template:**
```bash
#!/usr/bin/env bash
EXERCISE="$1"
BINARY="/tmp/assemblings_$$"
trap 'rm -f "$BINARY"' EXIT

if grep -q "I AM NOT DONE" "$EXERCISE"; then
    echo "  Remove the '// I AM NOT DONE' line to proceed."
    exit 1
fi

if ! clang -o "$BINARY" "$EXERCISE" 2>/tmp/asm_err_$$; then
    echo "  Compilation failed:"
    sed 's/^/    /' /tmp/asm_err_$$
    rm -f /tmp/asm_err_$$; exit 1
fi
rm -f /tmp/asm_err_$$

# Option A — check exit code:
"$BINARY" 2>/dev/null; code=$?
if [[ $code -eq 42 ]]; then
    echo "  Exit code correct: $code"
    exit 0
else
    echo "  Expected exit code: 42"
    echo "  Got exit code:      $code"
    exit 1
fi

# Option B — check stdout:
# output=$("$BINARY" 2>&1 || true)
# expected="Hello, World!"
# if [[ "$output" == "$expected" ]]; then
#     echo "  Output correct: '$output'"
#     exit 0
# else
#     echo "  Expected: '$expected'"
#     echo "  Got:      '$output'"
#     exit 1
# fi
```

### 4. Write the hint

Name it `.<exercise>.hint` (hidden). Aim for 10–20 lines. Good hints:
- Show the corrected pattern without solving it completely
- Trace execution to show why the bug produces the wrong result
- Explain the underlying concept once more in a different way

### 5. Create the backup

```bash
cp exercises/mytopic/myexercise.s exercises/mytopic/myexercise.orig.s
```

This is used by `assemblings reset`. Without it, reset fails.

### 6. Make the test script executable

```bash
chmod +x exercises/mytopic/.myexercise.test.sh
```

### 7. Verify both the broken and fixed states

```bash
# Should fail (bug is present):
assemblings verify myexercise

# Create a correct solution in a temp file:
t=$(mktemp); mv "$t" "${t}.s"; t="${t}.s"
cat > "$t" << 'EOF'
.global _main
.align 2
_main:
    // your correct solution
EOF
bash exercises/mytopic/.myexercise.test.sh "$t"
rm "$t"
```

## Writing Good Exercises

**One bug per exercise.** Each exercise should require exactly one change. If you find yourself fixing two things, split it into two exercises.

**Make the bug obvious but not trivial.** The learner should need to understand the concept to fix it, not just spot a typo.

**Use exit codes for numeric results, stdout for string output.** Exit codes (0–255) work well for arithmetic and register exercises. Stdout comparison works for intro/syscall exercises.

**Avoid infinite loops.** Buggy exercises should still terminate — they just produce the wrong exit code or output. A loop with a wrong accumulator is fine; a loop with a missing branch condition is not.

**Write helpful failure messages.** When a test fails, the output is the learner's only feedback. Show expected vs got, and add a tip for the most likely mistake.

## Compatibility

All exercises must work with:
- **Apple clang** (Xcode Command Line Tools) — `clang -o binary exercise.s`
- **ARM64 macOS** (Apple Silicon M1/M2/M3/M4)
- **macOS syscall convention**: `svc #0x80`, exit=x16#1, write=x16#4

Do not use:
- NASM syntax (x86 only)
- Linux syscall numbers or `svc #0` (Linux ARM64)
- Instructions that require NEON/SVE unless the topic specifically covers them
- External linker flags beyond what `clang exercise.s -o binary` provides

## Submitting Changes

1. Fork and create a branch: `git checkout -b add-exercise-udiv`
2. Follow the steps above
3. Run `assemblings list` to confirm your exercise appears in order
4. Open a pull request describing what concept the exercise teaches
