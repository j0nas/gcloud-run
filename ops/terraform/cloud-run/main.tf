provider "google" {
  credentials = file("./service-account.json")
  project     = var.google_project_id
  region      = var.google_region
}

resource "google_cloud_run_service" "default" {
  name     = var.google_service_name
  location = var.google_region
  autogenerate_revision_name = true

  template {
    spec {
      containers {
        image = "gcr.io/${var.google_project_id}/${var.google_service_container_name}"
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

locals {
  apex_domain = var.domain_mappings[0]
  dns_records = {
    "A" = [
      for rr in google_cloud_run_domain_mapping.default[0].status[0].resource_records :
      rr.rrdata if rr.type == "A"
    ]
    "AAAA" = [
      for rr in google_cloud_run_domain_mapping.default[0].status[0].resource_records :
      rr.rrdata if rr.type == "AAAA"
    ]
    "TXT" = [
      var.google_site_verification_record
    ]
  }
}

resource "google_dns_managed_zone" "default" {
  name = "dns-zone-for-${replace(local.apex_domain, ".", "-")}"
  dns_name = "${local.apex_domain}."
}

resource "google_dns_record_set" "default" {
  for_each = local.dns_records
  managed_zone = google_dns_managed_zone.default.name
  name    = "${local.apex_domain}."
  ttl     = 300
  type    = each.key
  rrdatas = each.value
}

resource "google_dns_record_set" "cname-records" {
  count = length(var.domain_mappings) - 1
  managed_zone = google_dns_managed_zone.default.name
  name = "${var.domain_mappings[count.index + 1]}."
  rrdatas = [
    google_cloud_run_domain_mapping.default[count.index + 1].status[0].resource_records[0].rrdata
  ]
  type = google_cloud_run_domain_mapping.default[count.index + 1].status[0].resource_records[0].type
  ttl = 300
}
