docker build -t victorm12/multi-client:latest -t victorm12/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t victorm12/multi server:latest -t victorm12/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t victorm12/multi-worker:latest -t victorm12/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push victorm12/multi-client:latest
docker push victorm12/multi-server:latest
docker push victorm12/multi-worker:latest
docker push victorm12/multi-client:$SHA
docker push victorm12/multi-server:$SHA
docker push victorm12/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=victorm12/multi-server:$SHA
kubectl set image deployments/client-deployment client=victorm12/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=victorm12/multi-worker:$SHA
