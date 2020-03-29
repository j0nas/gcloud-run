provider "google" {
  project     = var.google_project_name
  region      = var.google_region
  credentials = file("./service-account.json")
}

resource "google_project_service" "run" {
  service = "run.googleapis.com"
}

resource "google_cloud_run_service" "service" {
  name     = var.google_service_name
  location = var.google_region

  template {
    spec {
      containers {
        image = "gcr.io/${var.google_project_name}/${var.google_service_name}@${var.google_image_digest}"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  depends_on = [
    google_project_service.run
  ]
}

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location = google_cloud_run_service.service.location
  service  = google_cloud_run_service.service.name

  policy_data = data.google_iam_policy.noauth.policy_data
}