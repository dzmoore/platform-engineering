#!/usr/bin/env bash

cat << EOF | kubectl apply -f -
apiVersion: gcp.upbound.io/v1beta1
kind: ProviderConfig
metadata:
  name: default
spec:
  projectID: $GCP_PROJECT_ID
  credentials:
    source: Secret
    secretRef:
      namespace: $GCP_CREDS_SECRET_NAMESPACE
      name: $GCP_CREDS_SECRET_NAME
      key: $GCP_CREDS_SECRET_KEY
EOF