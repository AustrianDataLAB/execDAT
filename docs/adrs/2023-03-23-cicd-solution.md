# Title

Date: 2023-03-23

## Status

__PROPOSED__

## Context

We need to dicide on a CI/CD solution for our project, so we can automate certain tasks, e.g., building, testing, releasing, etc..

## Decision

Some choices for our CICD platform would be GitHub Actions, Tekton, Jenkins or Argo CD. Solutions like Tekton or Argo CD are build up upon Kubernetes, are cloud-native and platform agnostic. GitHub Actions workflows are much simpler and only require a yaml file for configuration. We decided to use GitHub Actions workflows because we already use GitHub for other related tasks, such as branch naming and protection rules, and therfore we have all of our configuration in one place. Additionally, GitHub Actions are much easier to setup and there are many already existing yaml configurations we can build up upon.

## Consequences

By choosing GitHub Action workflows, compared to running custom workflows in a Kubernetes environment with other solutions, we have a much simpler setup. But we are also more limited in our possibilities, as you have more options in a custom Kubernetes cluster.
