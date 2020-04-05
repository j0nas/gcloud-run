provider "google" {
  credentials = file("./service-account.json")
  project     = var.google_project_id
  region      = var.google_region
}

resource "google_cloud_run_service" "default" {
  name     = var.google_service_name
  location = var.google_region

  template {
    spec {
      containers {
        image = "gcr.io/${var.google_project_id}/${var.google_service_name}"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
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
  location = google_cloud_run_service.default.location
  service  = google_cloud_run_service.default.name
  policy_data = data.google_iam_policy.noauth.policy_data
}

resource "google_cloud_run_domain_mapping" "default" {
  count = length(var.domain_mappings)
  location = var.google_region
  name     = var.domain_mappings[count.index]

  metadata {
    namespace = var.google_project_id
  }

  spec {
    route_name = google_cloud_run_service.default.name
  }
}
