resource "google_service_account" "gke_service_account" {
  account_id   = "gke-service-account"
  display_name = "GKE Service Account"
}

resource "google_project_iam_binding" "gke_binding" {
  project = var.project_id
  role    = "roles/container.admin"

  members = [
    "serviceAccount:${google_service_account.gke_service_account.email}",
  ]
}

resource "google_project_iam_binding" "compute_binding" {
  project = var.project_id
  role    = "roles/compute.networkAdmin"

  members = [
    "serviceAccount:${google_service_account.gke_service_account.email}",
  ]
}

resource "google_project_iam_binding" "storage_binding" {
  project = var.project_id
  role    = "roles/storage.admin"

  members = [
    "serviceAccount:${google_service_account.gke_service_account.email}",
  ]
}

