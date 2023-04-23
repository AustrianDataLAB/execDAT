# Lecture 9

**- implemented adding at least one environment value and prove it is being read by the application**

Go to `kubernetes/deployments/pacman-deployment.yaml` and add an environment variable to the `env:` key. E.g.:

```
- name: MY_ENV_VAR
  value: "Lecture9"
```

Apply the changes with `kubectl apply -f <deployment.yaml>`
You can check the environment variable of your deployed pod with this command
`kubectl exec <pod name> -- printenv | grep MY_ENV_VAR`


**- discuss for what env should be used (think about the 12-factor)**

Configs that varry significantly between different deploys (e.g. resource handles, credentials, canonical hostnames in DNS records), should be separated from code in order to be flexible and avoid information leaks. E.g. config files have the problem that they can accidently checked into version control and potentially leak credentials for external services.

Environment variables can easily be changed between separate deployments without changing the code, centralize configurations for an app and allow for grouping into different environments.

**- delete or modify mongo's pvc and explain what happens (check the pv)**

When we `kubectl delete pvc <pvc name>`, the pvc goes from status BOUND into TERMINATING. This is due to [Storage Object in Use Protection](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#storage-object-in-use-protection), which postpones the deletion until the pvc is no longer in use by the pod, to protect from accidental data loss. You can see if a pvc or pv is protected when you let kubernetes describe it and see `kubernetes.io/pvc-protection` or `kubernetes.io/pv-protection` in the finalizers.

**- explain the difference between a pv and a pvc**

A PV is an independend resouce in the cluster that represents some type of storage. It has a separate lifecycle from any pod but can be bound to one using a PVC.

A PVC represents a request for storage in the cluster. PVC configurations are applied to a pod. Kubernetes then searches for any PVs that satisfy the requirements in the PVC and binds a matching PV to the pod.

**- inspect mongodb contents without using any ingress to the mongo-pod: write down how you achieved that**

`kubectl exec -it <mongo pod> -- bash`
**- try to alter the secret , explain what happened**

- modify the replication factor while altering the deployment strategy , what happens ? (did this make sense?, discuss)

- redeploy the application after some minor change, alter the deployment strategy , decide which deployment strategy is best for mongodb vs which is best for pacman ? Why did you make this choice?

- explain the difference between liveness health and readiness probe, modify the manifests and show clearly how they behave. Is it like you expected? Discuss how having them (or some of them) is differently important for the mongodb vs pacman deployment strategy (see point above)

- what use case do you see for a post start hook for a database deployment?

- last but not least: make the pod die from a OOM (out of memory) by setting resource limits and resource requests . Discuss which setting does what and how to calculate the memory limit
