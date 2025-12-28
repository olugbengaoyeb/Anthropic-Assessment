#!/usr/bin/env bash
set -euo pipefail

echo "[INFO] Starting Minikube..."
minikube start

echo "[INFO] Applying Kubernetes manifests..."
kubectl apply -f .

echo "[INFO] Waiting for frontend rollout..."
kubectl rollout status deployment/frontend

echo "[INFO] Opening frontend service..."
minikube service frontend

echo "[INFO] Deployment completed!"
