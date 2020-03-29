variable "google_project_name" {
  description = "Name of the project to use"
  default     = "gcloud-run"
}

variable "google_service_name" {
  description = "Name of the service to use"
  default     = "backend"
}

variable "google_region" {
  description = "Which Google datacenter to use"
  default     = "europe-north1"
}

variable "google_image_digest" {
  description = "The docker image digest to deploy."
  default     = "latest"
}
