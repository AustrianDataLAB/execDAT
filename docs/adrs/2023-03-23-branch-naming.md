# Branch Naming

Date: 2023-03-23

## Status
__PROPOSED__

## Context
We want a unified naming scheme for the naming of branches. Currently, no concrete scheme was decided on and we had a discussion between `feature/`, `features/` and `issue/` prefixes for branches beside `dev` or `main`.

## Decision
We decided on the following namings:
* `main` for the main branch
* `dev` for the development branch
* `feature/` for all branches that implement a new functionality or feature
* `issue/` for all branches that are concerned with a bug-fixe or issue
* `testing/` for all branches that fit neither `feature/` or `issue/`

We researched Pre-Commit-Hooks to enforce this, however a local installation of the CLI tool would be required and we do not want the added tool requirements and complexity.

Instead we will use the __branch protection rules__ to pattern match all other names and lock the corresponding branches. This should correspond some type of enforcing.

## Consequences
* developers need to adhere to the naming scheme for branches
* tighter control over the branch protection rules because we only have a small set of legal names