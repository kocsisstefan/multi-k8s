docker build -t kocsisstefan/multi-client:latest -t kocsisstefan/multi-client:$SHA  -f ./client/Dockerfile ./client
docker build -t kocsisstefan/multi-server:latest -t kocsisstefan/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kocsisstefan/multi-worker:latest -t kocsisstefan/multi-worker:$SHA  -f ./worker/Dockerfile ./worker

docker push kocsisstefan/multi-client:latest
docker push kocsisstefan/multi-server:latest
docker push kocsisstefan/multi-worker:latest

docker push kocsisstefan/multi-client:$SHA
docker push kocsisstefan/multi-server:$SHA
docker push kocsisstefan/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kocsisstefan/multi-server:$SHA
kubectl set image deployments/client-deployment client=kocsisstefan/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kocsisstefan/multi-worker:$SHA