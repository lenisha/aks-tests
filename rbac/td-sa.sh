#!/bin/bash

# Variables
NAMESPACE=ernie
SERVICEACCOUNT=ernie
ROLE=l6dev

# Set File Permissions
chmod a+x sa-namespace-setup.sh
chmod a+x sa-rbac-config-admin.sh
chmod a+x sa-rbac-config-l6dev.sh

# Create Namespace
kubectl create namespace $NAMESPACE
# Setup Namespace & Configure Service Account for Namespace
./sa-namespace-setup.sh $SERVICEACCOUNT $NAMESPACE
# Create AKS ServiceAccount, Role and Bindings
./sa-rbac-config-$ROLE.sh $SERVICEACCOUNT $NAMESPACE $ROLE
# Test Access by Getting List of ServiceAccounts and Pods in dev Namespace
KUBECONFIG="kube/k8s-${SERVICEACCOUNT}-${NAMESPACE}-conf" kubectl get pods
