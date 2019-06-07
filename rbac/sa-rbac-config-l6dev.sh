#!/bin/bash

SERVICE_ACCOUNT=$1
NAMESPACE="$2"
ROLE="$3"

echo -e "\\nCreating role: ${ROLE} on namespace: ${NAMESPACE}"
kubectl apply -f ${ROLE}-role.yaml

echo -e "\\nCreating a role binding: ${ROLE} for ${SERVICE_ACCOUNT_NAME} on namespace: ${NAMESPACE}"

cat <<EOF | kubectl apply -f -
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: RoleBinding
metadata:
  name: ${SERVICE_ACCOUNT}-dev-binding
  namespace: ${NAMESPACE}
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: ${ROLE}
subjects:
  - kind: ServiceAccount
    name: ${SERVICE_ACCOUNT}
    namespace: ${NAMESPACE}
EOF
