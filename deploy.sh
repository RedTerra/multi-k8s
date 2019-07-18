docker build -t xterase2001/multi-client:latest -t xterase2001/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t xterase2001/multi-server:latest -t xterase2001/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t xterase2001/multi-worker:latest -t xterase2001/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push xterase2001/multi-client:latest
docker push xterase2001/multi-server:latest
docker push xterase2001/multi-worker:latest

docker push xterase2001/multi-client:$SHA
docker push xterase2001/multi-server:$SHA
docker push xterase2001/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=xterase2001/multi-server:$SHA
kubectl set image deployments/client-deployment client=xterase2001/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=xterase2001/multi-worker:$SHA


