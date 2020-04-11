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

resource "google_dns_managed_zone" "default" {
  name = "dns-zone"
  dns_name = "dev.pictures."

  dnssec_config {
    kind = "dns#managedZoneDnsSecConfig"
    non_existence = "nsec3"
    state = "off"

    default_key_specs {
      algorithm = "rsasha256"
      key_length = 2048
      key_type = "keySigning"
      kind = "dns#dnsKeySpec"
    }

    default_key_specs {
      algorithm = "rsasha256"
      key_length = 1024
      key_type = "zoneSigning"
      kind = "dns#dnsKeySpec"
    }
  }
}

resource "google_dns_record_set" "a-records" {
  managed_zone = google_dns_managed_zone.default.name
  name = "dev.pictures."
  rrdatas = [
    google_cloud_run_domain_mapping.default[0].status[0].resource_records[0].rrdata,
    google_cloud_run_domain_mapping.default[0].status[0].resource_records[1].rrdata,
    google_cloud_run_domain_mapping.default[0].status[0].resource_records[2].rrdata,
    google_cloud_run_domain_mapping.default[0].status[0].resource_records[3].rrdata,
  ]
  type = google_cloud_run_domain_mapping.default[0].status[0].resource_records[0].type
  ttl = 300
}

resource "google_dns_record_set" "aaaa-records" {
  managed_zone = google_dns_managed_zone.default.name
  name = "${var.domain_mappings[0]}." # TODO: map var.domain_mappings
  rrdatas = [
    google_cloud_run_domain_mapping.default[0].status[0].resource_records[4].rrdata,
    google_cloud_run_domain_mapping.default[0].status[0].resource_records[5].rrdata,
    google_cloud_run_domain_mapping.default[0].status[0].resource_records[6].rrdata,
    google_cloud_run_domain_mapping.default[0].status[0].resource_records[7].rrdata,
  ]
  type = google_cloud_run_domain_mapping.default[0].status[0].resource_records[4].type
  ttl = 300
}
