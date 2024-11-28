# Define URL Shortener Deployment
resource "kubernetes_deployment" "url_shortener" {
  metadata {
    name = "url-shortener"
    labels = {
      app = "url-shortener"
    }
  }

  spec {
    replicas = 1  # Adjust the number of replicas as needed

    selector {
      match_labels = {
        app = "url-shortener"
      }
    }

    template {
      metadata {
        labels = {
          app = "url-shortener"
        }
      }

      spec {
        container {
          name  = "url-shortener"
          image = "your-url-shortener-image:latest"  # Replace this with your image
          port {
            container_port = 8080  # Exposing port 8080
          }

          # Optional: Add environment variables for the container
          env {
            name  = "ENVIRONMENT"
            value = var.environment
          }
        }
      }
    }
  }
}

# Define URL Shortener Service
resource "kubernetes_service" "url_shortener" {
  metadata {
    name      = "url-shortener"
    namespace = var.namespace
  }

  spec {
    selector = {
      app = "url-shortener"
    }

    port {
      port        = 8080
      target_port = 8080
      node_port   = var.nodeport
    }

    type = "NodePort"
  }
}
