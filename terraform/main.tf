module "network" {
  source       = "./modules/network"
  network_name = var.network_name
  subnet_name  = var.subnet_name
  region       = var.region
}

module "iam" {
  source     = "./modules/iam"
  project_id = var.project_id
}

module "gke" {
  source              = "./modules/gke"
  cluster_name        = var.cluster_name
  region              = var.region
  network_id          = module.network.network_id
  subnet_id           = module.network.subnet_id
  machine_type        = var.machine_type
  node_count          = var.node_count
  gke_service_account = module.iam.gke_service_account_email
}

module "kubernetes" {
  source     = "./modules/kubernetes"
  project_id = var.project_id
  image_tag  = "v1"
}

module "monitoring" {
  source      = "./modules/monitoring"
  alert_email = var.alert_email
}


# Implement Policy as Code (OPA Integration can be added here)

# Add any additional resources or modules as needed

