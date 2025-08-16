# Usage
* Run `devbox shell` in terminal
* Run `just start-control-plane` to start kind, etc.
* Run `just clean` to clear out build files, stop kind, etc.

# GCP
```shell
echo "Come up with a GCP project id.  Set it with 'export GCP_PROJECT_ID=id-goes-here'"

gcloud projects create $GCP_PROJECT_ID

echo "Open URL and enable API:"
echo "https://console.cloud.google.com/marketplace/product/google/container.googleapis.com?project=$GCP_PROJECT_ID"

export SA_NAME=admin-svc-acct
export SA="${SA_NAME}@${GCP_PROJECT_ID}.iam.gserviceaccount.com"

gcloud iam service-accounts create $SA_NAME --project $GCP_PROJECT_ID

export ROLE="roles/admin"

gcloud projects add-iam-policy-binding --role $ROLE $GCP_PROJECT_ID \
  --member serviceAccount:$SA

gcloud iam service-accounts keys create gcp-creds.json \
  --project $PROJECT_ID --iam-account $SA

echo "Run: cat gcp-creds.json"
echo "Go to https://github.com/$GITHUB_REPOSITORY/settings/secrets/codespaces"
echo "Add repository secrets:"
echo "GCP_CREDS should be your 'cat gcp-creds.json'"
echo "GCP_PROJECT_ID should be $GCP_PROJECT_ID"

```