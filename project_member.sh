#!/bin/bash

EMAIL=$(gcloud auth list --filter=status:ACTIVE --format="value(account)")
echo "Active user account is $EMAIL"
echo "Obtaining list of projects with member access..."

for PROJECT in $(\
  gcloud projects list \
  --format="value(projectId)" )
do
  gcloud projects get-iam-policy $PROJECT --format="json" | \
  awk -v project="$PROJECT" -v email="$EMAIL" '$0 ~ email {print project}'
done
