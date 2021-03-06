#!/bin/bash

BUILD_DIR=$GITHUB_WORKSPACE/.github/scripts/build
cd $BUILD_DIR

file=$(cat "$1")

if [[ $# == 3 ]]; then
    pattern_template="$3"

    if [[ ! ${file//$'\n'/' '} =~ $pattern_template ]]; then
        echo "❌ You haven't instantiated template class"
        exit 1
    fi
fi

lcov --directory . --capture --output-file coverage.info > /dev/null
lcov --extract coverage.info "*/$2" --output-file coverage.info > /dev/null

report=$(lcov --list coverage.info)
pattern_lcov="$2\s*\|\s*([0-9]{2,3}(\.[0-9])?)%"

if [[ ${report//$'\n'/' '} =~ $pattern_lcov ]]; then
    if (( $(echo "${BASH_REMATCH[1]} > 90.0" | bc -l) )); then
        echo "✅ Test coverage rate is higher than 90%"
    else
        echo "❌ Test coverage rate is lower than 90%"
        genhtml coverage.info -o report > /dev/null
        exit 1
    fi
else
    echo "Couldn't find coverage rate"
    exit 1
fi
