# Coders school - GitHub actions

## Coverage rate comment action
Adds comment saying that coverage rate is too low.
It also contains a link to the action's summary when you can find a detailed coverage report as an artifact.

Comment content:
> Coverage rate is less than 90%. You can download detailed coverage report in action's summary. Look for Artifacts in the bottom of this page

### Usage
```yaml
- uses: coders-school/github-actions/coverage-rate-comment@main
  if: ${{ failure() && github.event_name == 'pull_request' }}
```

## Run tests action
Builds and runs tests.
Build directory is `.github/scripts/build`.
To work properly, it needs a CMakeLists.txt file in `.github/scripts`.
CMake will be provided with 2 parameters:
- `TASK` - task name that should be built
- `TEST_FRAMEWORK` - UT framework that should be used (catch2 or gtest)

### Parameters
- `task_name` - name of the task (*required*)
- `test_file` - path to the file containing tests (*required*)
- `test-to_run` - name of the executable to build and run (default value is equal to `task_name`)

### Usage
```yaml
- uses: coders-school/github-actions/run-tests@main
  with:
    task_name: 'unique_ptr'
    test_file: '../tests/unique_ptr_tests.cpp'
```

```yaml
- uses: coders-school/github-actions/run-tests@main
  with:
    task_name: 'unique_ptr'
    test_file: '../../../homework/unique_ptr/unique_ptr_tests.cpp'
    test_to_run: 'unique_ptr_student'
```

## Coverage check action
Builds and runs tests.
Then runs coverage check.
It uses both "Run tests" and "Coverage rate comment" actions.

### Parameters
- `task_name` - name of the task (*required*)
- `test_file` - path to the file containing tests (*required*)
- `test-to_run` - name of the executable to build and run (default value is equal to `task_name`)
- `lcov_file` - name of the file that need to be included in coverage report (*required*)
- `template_pattern` - regex pattern that matches template instantiation. If it's not provided, template instantiation check will be skipped.

### Usage
```yaml
- uses: coders-school/github-actions/coverage-check@main
  with:
    task_name: 'unique_ptr'
    test_file: '../../../homework/unique_ptr/unique_ptr_tests.cpp'
    test_to_run: 'unique_ptr_student'
    lcov_file: 'unique_ptr.hpp'
    template_pattern: 'template\s*class\s*my::unique_ptr<\s*\w+\s*>'
```

```yaml
- uses: coders-school/github-actions/coverage-check@main
  with:
    task_name: 'unique_ptr'
    test_file: '../../../homework/unique_ptr/unique_ptr_tests.cpp'
    test_to_run: 'unique_ptr_student'
    lcov_file: 'unique_ptr.hpp'
```

## Clang-format check
Checks code formatting using clang-format.
It requires `.clang-format` file in repo's top-level directory.

### Parameters
- `check_path` - path to task directory (*required*)

### Usage
```yaml
- uses: coders-school/github-actions/clang-format-check@main
  with:
    check-path: 'homework/shared_ptr'
```
