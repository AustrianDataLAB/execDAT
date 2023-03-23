# Decide if source code an data of users can be private.

Date: 2023-03-16

## Status
__ACCEPTED__

## Context

The jobs need to access the data and source code of the user in order to create the image and run the task. Private repositories need additional user authentication whereas public ones don't.

## Decision

For now we only allow public code repositories and data sources. This means that the code and data of the user is public. This is the easiest way to implement the jobs. We can always change this later.

## Consequences

This means that the user has to make the code and data public. This is not a problem for the user, because the user wants to publish the code and data anyway. The user can always make the code and data private later.