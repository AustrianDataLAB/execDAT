# execDAT

execDAT - remote code execution for research 

## TL;DR

We enable researchers to run their source code on remote execution environments through a single interface.

Normally this would require a researcher to complete the following steps:
- build a container image with their source code
- push the image to a registry
- push the data to somewhere the cluster has access to
- create k8s manifests to deploy everything in a cluster
- publish the results somewhere to access afterwards

With our application, these steps are simplified to writing a single standardized development environment configuration file and applying it using our provided CLI tool.

## Getting Started

### Prerequisites

* k3d
* docker

### Start k3d cluster

```shell
k3d cluster create -c k3d-dev.yaml
```
