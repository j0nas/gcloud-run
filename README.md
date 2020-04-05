# Cloud Run

Node.js project to test Google Cloud Run.

Project ID: gcloud-test-run
Project name: gcloud-run
Service name: backend
Region: europe-north1

## Features

- [x] Cloud Run project
- [x] Cloud Build
  - [x] Continuous Deployment
  - [x] Continuous Integration

## Google Cloud project setup

1. Create your project in Google Cloud console.
2. Set the appropriate variables in /ops/terraform/cloud-run/variables.tf
3. `gcloud services enable cloudresourcemanager.googleapis.com`

## Cloud Build setup

1. [Service Account Settings](https://console.cloud.google.com/cloud-build/settings?_ga=2.236470785.1229268789.1585354558-2078502783.1565611039) ->
   "Cloud Run Admin": "Enabled" and "GRANT ACCESS TO ALL SERVICE ACCOUNTS"
2. [Triggers](https://console.cloud.google.com/cloud-build/triggers) -> "Connect Repository"

## Zeit.co Domains setup:

1. Buy zeit.co domain
2. Delete Zeit's SSL certificates
3. Add "Custom Domain mapping" in GCP

TODO:

- [ ] Terraform setup for this, so that new projects can be automatically set up
- [ ] Monitoring (e.g. through [cAdvisor](https://github.com/google/cadvisor))
- [ ] Cache CI build step
