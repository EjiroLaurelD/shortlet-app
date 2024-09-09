variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
  default     = "us-central1"
}

variable "cluster_name" {
  description = "The name of the GKE cluster"
  type        = string
  default     = "my-gke-cluster"
}

variable "network_name" {
  description = "The name of the custom VPC network"
  type        = string
  default     = "shortlet-app"
}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
  default     = "shortlet-subnet"
}

variable "machine_type" {
  description = "The machine type for GKE nodes"
  type        = string
  default     = "e2-medium"
}

variable "node_count" {
  description = "The number of nodes in the GKE cluster"
  type        = number
  default     = 3
}

variable "alert_email" {
  description = "Email address for alerts"
  type        = string
  default     = "ejiro.dafe@gmail.com"
}

