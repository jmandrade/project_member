#!/bin/bash

EMAIL=$(gcloud auth list --filter=status:ACTIVE --format="value(account)")
echo "Active user account is $EMAIL"
echo "Obtaining list of projects with member access..."

for PROJECT in $(\
  gcloud projects list \
  --format="value(projectId)" )
do
  gcloud projects get-iam-policy $PROJECT --format="json" | \
  awk -v awkvarproject="$PROJECT" awkvaremail="$EMAIL" '{if ($0 ~ /awkvaremail/) {print awkvarproject}}'
done
