package terraform.policies

import data.terraform.resources

deny[msg] {
  resource := resources[_]
  resource.type == "google_compute_firewall"
  not resource.name == "allow-http"
  msg := sprintf("Firewall rule '%s' is not allowed.", [resource.name])
}

deny[msg] {
  resource := resources[_]
  resource.type == "google_compute_network"
  not resource.name == "shortlet-app"
  msg := "Only the 'shortlet-app' VPC network is allowed."
}

