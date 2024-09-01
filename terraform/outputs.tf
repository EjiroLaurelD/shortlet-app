output "api_endpoint" {
  description = "The public IP address of the API"
  value       = kubernetes_service.api_service.status[0].load_balancer[0].ingress[0].ip
}

output "cluster_name" {
  description = "The name of the GKE cluster"
  value       = google_container_cluster.primary.name
}

output "cluster_endpoint" {
  description = "The endpoint of the GKE cluster"
  value       = google_container_cluster.primary.endpoint
}

