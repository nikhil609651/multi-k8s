docker build -t nikhil609651/multi-client:latest -t nikhil609651/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t nikhil609651/multi-server:latest -t nikhil609651/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t nikhil609651/multi-worker:latest -t nikhil609651/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push -t nikhil609651/multi-client:latest
docker push -t nikhil609651/multi-server:latest
docker push -t nikhil609651/multi-worker:latest
docker push -t nikhil609651/multi-client:$SHA
docker push -t nikhil609651/multi-server:$SHA
docker push -t nikhil609651/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=nikhil609651/multi-server:$SHA
kubectl set image deployments/client-deployment client=nikhil609651/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=nikhil609651/multi-worker:$SHA