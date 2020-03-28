Cloud Run
===

Node.js project to test Google Cloud Run. 

Project ID: gcloud-test-run
Project name: gcloud-run
Service name: backend
Region: europe-north1

- [x] Cloud Run project
- [x] Cloud Build Continuous Deployment
  - [Service Account Settings](https://console.cloud.google.com/cloud-build/settings?_ga=2.236470785.1229268789.1585354558-2078502783.1565611039) ->
    "Cloud Run Admin": "Enabled" and "GRANT ACCESSS TO ALL SERVICE ACCOUNTS" 
  - [Triggers](https://console.cloud.google.com/cloud-build/triggers) -> "Connect Repository"


TODO:
 - [ ] Terraform setup for this, so that new projects can be automatically set up