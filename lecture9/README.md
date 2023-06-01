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

Directly via the mongo shell from inside the mongodb pod:
```bash
kubectl exec -it deployment/mongo -- bash -c 'mongo -u root -p $MONGODB_ROOT_PASSWORD'
kubectl exec -it deployment/mongo -- bash -c 'mongo -u $MONGODB_USERNAME -p $MONGODB_PASSWORD --authenticationDatabase $MONGODB_DATABASE'
```
Export the credentials from the secret and connect to the mongo pod via port forwarding:
```bash
kubectl get secret mongodb-users-secret -o go-template='{{range $k,$v := .data}}{{printf "export %s=" $k}}{{if not $v}}{{$v}}{{else}}{{$v | base64decode}}{{end}}{{"\n"}}{{end}}'
kubectl port-forward svc/mongo 27017:27017
```

**- try to alter the secret , explain what happened**

If we update just the secret directly in k8s, nothing changes. This is because the secret is exposed as an environment variable in the pod and the pod needs to be restarted for the changes to take effect. We can do this by deleting the pod, which will be recreated by the deployment.

**- modify the replication factor while altering the deployment strategy, what happens ? (did this make sense?, discuss)**

Recreate:
- all pods are deleted and then recreated. There is a short downtime where no pod is available.
  
RollingUpdate:
- the pods are updated sequentially, depending on the max surge factor (maximum number of Pods that can be created over the desired number of Pods) and the max unavailable pods (max unavailable pods at a time)
- both factors can be absolute numbers or percentages of the desired number of pods

As the default value was 25% for both factors and the number of replicas was 3, the pods were updated one by one.
But as we set the replicas to 4 we had at one point 2 pods running the old version and 2 pods running the new version.

**Scenarios:**

- 3 replicas, MaxSurge: 1, MaxUnavailable: 0 - one after another:
  - 1 new pod gets created before 1 old pod is deleted

- 3 replicas, MaxSurge: 0, MaxUnavailable: 1 - one after another:
  - 1 old pod gets deleted before 1 new pod is created


**- redeploy the application after some minor change, alter the deployment strategy , decide which deployment strategy is best for mongodb vs which is best for pacman ? Why did you make this choice?**

In this case we cannot scale mongodb horizontally, as it is a single node database. So we need to use the recreate strategy, as the rolling update strategy would not work. (There is a replicaset solution for mongodb, but this is not covered in this course)

For pacman we can scale horizontally, so we can use the rolling update strategy.

**- explain the difference between liveness health and readiness probe, modify the manifests and show clearly how they behave. Is it like you expected? Discuss how having them (or some of them) is differently important for the mongodb vs pacman deployment strategy (see point above)**

Liveness probe:
Periodic probe of container liveness. Container will be restarted if the probe fails. This is useful in situations where the container may become stuck in a non-responsive state but the underlying infrastructure is still running.

Readiness probe:
Periodic probe of container service readiness. Container will be removed from service endpoints if the probe fails, and traffic will be redirected to other available containers This is useful in situations where a container needs time to start up properly, or if a container needs to perform some initial setup before it can start accepting traffic.

If the deployment strategy is set to recreate (as with mongodb) and the readiness probe is set to `initialDelaySeconds: 60`, the pod will be in status `Running` but not ready for 60 seconds. This is because the readiness probe is only executed after the initial delay. This would mean that the pod is at least not ready for 60 seconds after the deployment.

In case of a rolling update strategy (as with pacman), the update just takes longer. But the other pods are still ready and can serve traffic if the updating pod can not get ready. So liveness is more important for pacman than mongodb here.

The difference between pacman and mongodb are also exec vs http probes. The exec probe just executes a command inside the container and checks the exit code. The http probe executes a http request against a specified endpoint and checks the response code.
Furthermore the delays differ between the two deployments.

**- what use case do you see for a post start hook for a database deployment?**

- creating databases and users respectively
- filling up databases with mock data, e.g., for testing
- migrating data from another database

**- last but not least: make the pod die from a OOM (out of memory) by setting resource limits and resource requests . Discuss which setting does what and how to calculate the memory limit**

```yaml
spec:
  ...
  resources: 
    limits:
      memory: 100Mi
    requests:
      cpu: 10m
      memory: 10Mi
```

```bash
# this will write 200M to memory and trigger an OOM kill (137)
kubectl exec -it deployment/pacman -- bash -c "cat /dev/zero | head -c 200M | tail"
```

The memory limit is the maximum amount of memory that a container can use. If the container tries to use more memory than the limit, the container is killed. The memory limit is enforced by the kernel.

To calculate the memory limit, we need to take into account the memory usage of the container and the memory usage of the processes running inside the container. The memory usage of the processes running inside the container is the most important factor. The memory usage of the container itself is usually very small.

Monitoring the memory usage of the processes running inside the container is not easy. We can use the `top` command to get a rough estimate of the memory usage of the processes running inside the container. But this is not very accurate. The `top` command shows the memory usage of the processes running inside the container at a certain point in time. The memory usage of the processes running inside the container can change over time. So we need to monitor the memory usage of the processes running inside the container over a longer period of time. This is not easy to do.