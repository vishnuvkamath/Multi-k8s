docker build -t nucoxia/multi-client-k8s:latest -t nucoxia/multi-client-k8s:$SHA ./client/Dockerfile ./client
docker build -t nucoxia/multi-server-k8s:latest -t nucoxia/multi-server-k8s:$SHA ./server/Dockerfile ./server
docker build -t nucoxia/multi-worker-k8s:latest -t nucoxia/multi-worker-k8s:$SHA ./worker/Dockerfile ./worker

docker push nucoxia/multi-client-k8s:latest
docker push nucoxia/multi-server-k8s:latest
docker push nucoxia/multi-worker-k8s:latest

docker push nucoxia/multi-client-k8s:$SHA
docker push nucoxia/multi-server-k8s:$SHA
docker push nucoxia/multi-worker-k8s:$SHA


kubectl apply -f k8s

kubectl set image deployments/client-deployment client=nucoxia/multi-client-k8s:$SHA
kubectl set image deployments/server-deployment server=nucoxia/multi-server-k8s:$SHA
kubectl set image deployments/worker-deployment worker=nucoxia/multi-worker-k8s:$SHA


