resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region

  network    = var.network_id
  subnetwork = var.subnet_id

  initial_node_count = var.node_count

  remove_default_node_pool = true
  min_master_version      = "latest"

  node_config {
    machine_type = var.machine_type
    oauth_scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    service_account = var.gke_service_account
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = "pods"
    services_secondary_range_name = "services"
  }

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "0.0.0.0/0"
      display_name = "All networks"
    }
  }

  network_policy {
    enabled = true
  }

  addons_config {
    http_load_balancing {}
    horizontal_pod_autoscaling {}
  }
}

resource "google_container_node_pool" "primary_nodes" {
  cluster    = google_container_cluster.primary.name
  location   = google_container_cluster.primary.location
  node_count = var.node_count

  node_config {
    machine_type = var.machine_type
    oauth_scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    service_account = var.gke_service_account
  }

  management {
    auto_upgrade = true
    auto_repair  = true
  }
}

