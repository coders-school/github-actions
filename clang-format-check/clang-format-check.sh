#!/bin/bash

find "$1" -regex '.*\.\(cpp\|hpp\|cc\|cxx\|h\)$' -not -regex ".*catch.*" | xargs -P$(nproc) -n2 clang-format -style=file -i

CHANGES=$(git --no-pager diff)
if [[ -n "$CHANGES" ]]; then
    echo "Fix formatting along with the diff:
    $CHANGES"
    exit 1
else
    echo "Everything is fine!"
fi
