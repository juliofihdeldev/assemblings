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

if [[ $code -eq 42 ]]; then
    echo "  Exit code correct: $code"
    exit 0
else
    echo "  Expected exit code: 42"
    echo "  Got exit code:      $code"
    exit 1
fi
