Stage 1

![stage-1](image.png)

Stage 2

![stage=2](image-1.png)

`kubectl get services`
internal IP address - cannot be accessed from the local machine
![Alt text](image-2.png)


`kubectl apply -f=auth-deployment.yaml -f=auth-service.yaml -f=users-deployment.yaml -f=users-service.yaml -f=tasks-service.yaml -f=tasks-deployment.yaml`

`kubectl get deployments`

![Alt text](image-3.png)

`kubectl get services`

![Alt text](image-4.png)

Start task service 

`minikube service tasks-service`

