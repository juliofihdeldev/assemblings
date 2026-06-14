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

"$BINARY" 2>/dev/null; code=$?

if [[ $code -eq 77 ]]; then
    echo "  Exit code correct: $code  (loaded 'first' = 77)"
    exit 0
else
    echo "  Expected exit code: 77  (value of 'first')"
    echo "  Got exit code:      $code"
    [[ $code -eq 99 ]] && echo "  Hint: you loaded 'second' (99) instead of 'first' (77)"
    exit 1
fi
