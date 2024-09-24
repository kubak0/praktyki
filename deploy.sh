#!/bin/bash

NAMESPACE="default"

if [ ! -f "deployment.yaml" ]; then
    echo "Plik deployment.yaml nie został znaleziony!"
    exit 1
fi

echo "Wdrażam aplikację w przestrzeni nazw $NAMESPACE..."

kubectl apply -f deployment.yaml -n $NAMESPACE

kubectl rollout status deployment/whoami -n $NAMESPACE
kubectl rollout status deployment/prometheus -n $NAMESPACE
kubectl rollout status deployment/grafana -n $NAMESPACE
kubectl rollout status deployment/gitea -n $NAMESPACE

if [ $? -eq 0 ]; then
    echo "Wdrożenie zakończone sukcesem!"
else
    echo "Wdrożenie nie powiodło się!"
    exit 1
fi
