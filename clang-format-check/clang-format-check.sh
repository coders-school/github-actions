#!/bin/bash

if [[ $# -ge 2 ]]; then
    find "$1" -regex '.*\.\(cpp\|hpp\|cc\|cxx\|h\)$' -not -path "$2/*" | xargs -P$(nproc) -n2 clang-format -style=file -i
else
    find "$1" -regex '.*\.\(cpp\|hpp\|cc\|cxx\|h\)$' | xargs -P$(nproc) -n2 clang-format -style=file -i
fi

CHANGES=$(git --no-pager diff)
if [[ -n "$CHANGES" ]]; then
    echo "Fix formatting along with the diff:
    $CHANGES"
    exit 1
else
    echo "Everything is fine!"
fi
