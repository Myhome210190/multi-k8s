docker build -t Myhome210190/multi-client:latest -t Myhome210190/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t Myhome210190/multi-server:latest -t Myhome210190/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t Myhome210190/multi-worker:latest -t Myhome210190/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push Myhome210190/multi-cient:latest
docker push Myhome210190/multi-server:latest
docker push Myhome210190/multi-worker:latest

docker push Myhome210190/multi-cient:$SHA
docker push Myhome210190/multi-server:$SHA
docker push Myhome210190/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=Myhome210190/multi-server:$SHA
kubectl set image deployments/client-deployment client=Myhome210190/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=Myhome210190/multi-worker:$SHA