resource "kubernetes_namespace" "app" {
  metadata {
    name = "my-app"
  }
}

resource "kubernetes_deployment" "api_deployment" {
  metadata {
    name      = "time-api"
    namespace = kubernetes_namespace.app.metadata[0].name
    labels = {
      app = "time-api"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "time-api"
      }
    }

    template {
      metadata {
        labels = {
          app = "time-api"
        }
      }

      spec {
        container {
          name  = "time-api"
          image = "gcr.io/${var.project_id}/my-time-api:v1"
          ports {
            container_port = 5000
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "api_service" {
  metadata {
    name      = "time-api"
    namespace = kubernetes_namespace.app.metadata[0].name
    labels = {
      app = "time-api"
    }
  }

  spec {
    selector = {
      app = "time-api"
    }

    port {
      port        = 80
      target_port = 5000
    }

    type = "LoadBalancer"
  }
}

