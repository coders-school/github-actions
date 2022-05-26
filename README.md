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
