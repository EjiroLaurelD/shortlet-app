resource "google_compute_firewall" "allow_http" {
  name    = "allow-http"
  network = google_compute_network.vpc_network.id

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server"]

  description = "Allow HTTP traffic to the API"
}

resource "google_compute_firewall" "allow_kubernetes" {
  name    = "allow-kubernetes"
  network = google_compute_network.vpc_network.id

  allow {
    protocol = "tcp"
    ports    = ["443", "22"]
  }

  source_ranges = ["10.0.0.0/16"]
  target_tags   = ["kubernetes"]

  description = "Allow Kubernetes internal traffic"
}

