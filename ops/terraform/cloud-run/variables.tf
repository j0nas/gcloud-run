variable "google_project_id" {
  description = "Name of the project to use"
  default     = "gcloud-test-run"
}

variable "google_service_name" {
  description = "Name of the service to use"
  default     = "backend"
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
  description = "Domain names to associate with this service. First entry must be the apex domain."
  default = [
    "jonas.fun",
    "lol.jonas.fun",
    "test.jonas.fun",
  ]
}

variable "google_site_verification_record" {
  description = "Verification record from Google Webmaster Central"
  default = "google-site-verification=j0yqXauYDrJlbIZnyY7ikVTTK_-4MeTqHT2bufkSo_Y"
}
