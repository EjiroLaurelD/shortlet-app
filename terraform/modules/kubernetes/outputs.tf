output "api_service_ip" {
  description = "The public IP of the API service"
  value       = kubernetes_service.api_service.status[0].load_balancer[0].ingress[0].ip
}

