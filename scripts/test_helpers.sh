#!/usr/bin/env bash
# test_helpers.sh — shared test helper functions for wrapper test suites.
#
# source this file at the top of each test script:
#   source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/test_helpers.sh"

passed=0
failed=0
total=0

pass() {
    passed=$((passed + 1))
    total=$((total + 1))
    echo "  PASS: $1"
}

fail() {
    failed=$((failed + 1))
    total=$((total + 1))
    echo "  FAIL: $1"
    if [[ -n "${2:-}" ]]; then
        echo "        $2"
    fi
}

assert_contains() {
    local file="$1"
    local needle="$2"
    local label="$3"

    if grep -Fq -- "$needle" "$file"; then
        pass "$label"
    else
        fail "$label" "missing '$needle' in $file"
    fi
}

assert_executable() {
    local file="$1"
    local label="$2"

    if [[ -x "$file" ]]; then
        pass "$label"
    else
        fail "$label" "$file is not executable"
    fi
}

print_summary() {
    echo ""
    echo "results: $passed passed, $failed failed, $total total"

    if [[ $failed -gt 0 ]]; then
        exit 1
    fi
}
