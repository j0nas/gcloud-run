variable "google_project_id" {
  description = "Name of the project to use"
  default     = "gcloud-test-run"
}

variable "google_service_name" {
  description = "Name of the service to use"
  default     = "backend-jonas"
}

variable "google_service_container_name" {
  description = "Name of the service to use"
  default     = "backend"
}

variable "google_region" {
  description = "Which Google datacenter to use"
  default     = "europe-north1"
}

variable "domain_mappings" {
  description = "Domain names to associate with this service"
  default = [
    "jonas.fun",
    "lol.jonas.fun",
    "test.jonas.fun",
  ]
}
