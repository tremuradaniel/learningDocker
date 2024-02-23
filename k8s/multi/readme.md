`kubectl exec -it [pod_name] -c [container_name] -- /bin/bash` - start a Bash shell inside the specified container in the specified pod, allowing you to interact with it as if you were SSH'ed into the container.
e.g.
`kubectl exec -it mydeployment-6698899cbc-t88dx -c server -- /bin/bash`