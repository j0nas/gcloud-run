variable "google_project_id" {
  description = "Name of the project to use"
  default     = "gcloud-test-run"
}

variable "google_service_name" {
  description = "Name of the service to use"
  default     = "backend"
}

variable "google_region" {
  description = "Which Google datacenter to use"
  default     = "europe-north1"
}
