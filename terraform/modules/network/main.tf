resource "google_compute_network" "vpc_network" {
  name                    = var.network_name
  auto_create_subnetworks = false
  description             = "Custom VPC network for Shortlet App"
}

resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet_name
  ip_cidr_range = "10.0.0.0/16"
  network       = google_compute_network.vpc_network.id
  region        = var.region
  description   = "Subnet for Shortlet App"
}

