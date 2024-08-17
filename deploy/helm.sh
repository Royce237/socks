#!/bin/bash

# Set variables
NAMESPACE="monitoring"
GRAFANA_PASSWORD="yourpassword"
NODE_PORT=32000  # You can change this to any available port in the range 30000-32767

# Create Namespace
kubectl create namespace $NAMESPACE

# Add Helm repositories for Prometheus and Grafana
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

# Deploy Prometheus using Helm
helm install prometheus prometheus-community/prometheus \
  --namespace $NAMESPACE

# Deploy Grafana using Helm with NodePort
helm install grafana grafana/grafana \
  --namespace $NAMESPACE \
  --set adminPassword=$GRAFANA_PASSWORD \
  --set service.type=NodePort \
  --set service.nodePort=$NODE_PORT

# Output information
echo "Prometheus and Grafana have been deployed in the $NAMESPACE namespace."
echo "Grafana is accessible on NodePort $NODE_PORT."
echo "Grafana URL: http://<NodeIP>:$NODE_PORT"
echo "Grafana Admin Password: $GRAFANA_PASSWORD"
