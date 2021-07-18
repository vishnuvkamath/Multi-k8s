docker build -t nucoxia/multi-client:latest -t nucoxia/multi-client:$SHA ./client/Dockerfile ./client
docker build -t nucoxia/multi-server:latest -t nucoxia/multi-server:$SHA ./server/Dockerfile ./server
docker build -t nucoxia/multi-worker:latest -t nucoxia/multi-worker:$SHA ./worker/Dockerfile ./worker

docker push nucoxia/multi-client:latest
docker push nucoxia/multi-server:latest
docker push nucoxia/multi-worker:latest

docker push nucoxia/multi-client:$SHA
docker push nucoxia/multi-server:$SHA
docker push nucoxia/multi-worker:$SHA


kubectl apply -f k8s

kubectl set image deployments/client-deployments client=nucoxia/multi-client:$SHA
kubectl set image deployments/server-deployments server=nucoxia/multi-server:$SHA
kubectl set image deployments/worker-deployments worker=nucoxia/multi-worker:$SHA


