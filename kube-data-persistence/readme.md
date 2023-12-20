Build and start image
`docker-compose up -d --build`


Persitent Volume and Persistent Volume Claim

`kubectl apply -f=host-pv.yaml`
`kubectl apply -f=host-pvc.yaml`
`kubectl apply -f=deployment.yaml`
