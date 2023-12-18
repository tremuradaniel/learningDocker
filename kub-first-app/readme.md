`docker build -t kub-first-app .`
`docker tag kub-first-app danielctremura/kub-first-app`
`docker push danielctremura/kub-first-app`

Send the image to the cluster

`kubectl create deployment first-app --image=danielctremura/kub-first-app`

Check create

`kubectl get deployments`
`kubectl get pods`

