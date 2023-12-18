`docker build -t kub-first-app .`
`docker tag kub-first-app danielctremura/kub-first-app`
`docker push danielctremura/kub-first-app`

Send the image to the cluster

`kubectl create deployment first-app --image=danielctremura/kub-first-app`

Check create

`kubectl get deployments`
`kubectl get pods`

Exposing a deployment with a service

`kubectl expose deployment first-app --type=LoadBalancer --port=8080`

Check service

`kubectl get services`

`minikube service first-app` - get the api to reach the docker container

Scalling 

`kubectl scale deployment/first-app --replicas=3`