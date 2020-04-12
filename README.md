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
2. `gcloud init`
3. Set the appropriate variables in /ops/terraform/cloud-run/variables.tf
4. `gcloud services enable cloudresourcemanager.googleapis.com`
5. Create a service account

## Cloud Build setup

1. [Service Account Settings](https://console.cloud.google.com/cloud-build/settings?_ga=2.236470785.1229268789.1585354558-2078502783.1565611039) ->
   "Cloud Run Admin": "Enabled" and "GRANT ACCESS TO ALL SERVICE ACCOUNTS"
2. [Triggers](https://console.cloud.google.com/cloud-build/triggers) -> "Connect Repository"

## Zeit.co Domains setup:

1. Buy zeit.co domain
2. Delete Zeit's SSL certificates
3. Add "Custom Domain mapping" in GCP

## Terraform setup

1. `npmR docker:build`
1. `npmR docker:push`
1. [Webmaster Central](https://www.google.com/webmasters/verification/details?hl=en-GB&domain=dev.pictures)
   verify domain ownership with TXT record -> "Add an owner" -> Add project service account

Then

- run `cd ./ops/terraform && ./tf.sh apply cloud-run`
- go to the created DNS zone and view zone details, click "Registrar Setup" in top-right corner
- Set the domain's nameserver to use Google's servers by copying over the shown addresses

TODO:

- [ ] Terraform setup for this, so that new projects can be automatically set up
- [ ] Monitoring (e.g. through [cAdvisor](https://github.com/google/cadvisor) or Datadog?)
- [ ] Cache CI build step
