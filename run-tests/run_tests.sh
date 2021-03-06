#!/bin/bash

BUILD_DIR=$GITHUB_WORKSPACE/.github/scripts/build
mkdir -p $BUILD_DIR
cd $BUILD_DIR

file=$(cat "$2")
test_to_run=$([ -z "$3" ] && echo "$1" || echo "$3")

regex="#include [<|\"]((catch2)|(gtest))"
if [[ $file =~ $regex ]]; then
    framework=${BASH_REMATCH[1]}
    cmake -DTEST_FRAMEWORK=$framework -DTASK=$1 .. && \
    make "$test_to_run" && \
    ./$test_to_run
else
    echo "Couldn't recognize test framework"
    exit 1
fi
