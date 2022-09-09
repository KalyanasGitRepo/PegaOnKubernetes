#1. Create namesspaces

kubectl create namespace mypega
kubectl create namespace pegaaddons
kubectl create namespace pegabackingservices

#2. Istall pega helm charts passing values.yaml
helm install mypega pega/pega --namespace mypega --values ./values-minimal.yaml


