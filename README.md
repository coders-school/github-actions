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
- `Task` - task name that should be built
- `Framework` - UT framework that should be used (catch2 or gtest)

### Parameters
- `task_name` - name of the task (*required*)
- `test_file` - path to the file containing tests (*required*)
- `test-to_run` - name of the executable to build and run (default value is equal to `task_name`)

### Usage
```yaml
uses: coders-school/github-actions/run-tests@main
with:
  task_name: 'unique_ptr'
  test_file: '../tests/unique_ptr_tests.cpp'
```

```yaml
uses: coders-school/github-actions/run-tests@main
with:
  task_name: 'unique_ptr'
  test_file: '../../../homework/unique_ptr/unique_ptr_tests.cpp'
  test_to_run: 'unique_ptr_student'
```
