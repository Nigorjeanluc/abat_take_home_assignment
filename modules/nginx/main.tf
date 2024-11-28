# Define Nginx Deployment
resource "kubernetes_deployment" "nginx" {
  metadata {
    name      = "nginx"
    namespace = var.namespace
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "nginx"
      }
    }

    template {
      metadata {
        labels = {
          app = "nginx"
        }
      }

      spec {
        container {
          name  = "nginx"
          image = "nginx:latest"

          port {
            container_port = 80
          }
        }
      }
    }
  }
}

# Define ConfigMap for dynamic index.html for Dev
resource "kubernetes_config_map" "nginx_config_dev" {
  count = var.environment == "dev" ? 1 : 0

  metadata {
    name      = "nginx-config"
    namespace = var.namespace
  }

  data = {
    "index.html" = <<-EOF
      <!DOCTYPE html>
      <html>
      <head>
          <title>Development Environment</title>
      </head>
      <body>
          <h1>Welcome to Development Environment</h1>
          <p>This is the DEV environment deployment.</p>
      </body>
      </html>
    EOF
  }
}

# Define ConfigMap for dynamic index.html for Prod
resource "kubernetes_config_map" "nginx_config_prod" {
  count = var.environment == "prod" ? 1 : 0

  metadata {
    name      = "nginx-config"
    namespace = var.namespace
  }

  data = {
    "index.html" = <<-EOF
      <!DOCTYPE html>
      <html>
      <head>
          <title>Production Environment</title>
      </head>
      <body>
          <h1>Welcome to Production Environment</h1>
          <p>This is the PROD environment deployment.</p>
      </body>
      </html>
    EOF
  }
}



# Define Nginx Service
resource "kubernetes_service" "nginx" {
  metadata {
    name      = "nginx"
    namespace = var.namespace
  }

  spec {
    selector = {
      app = "nginx"
    }

    port {
      port        = 80
      target_port = 80
      node_port   = var.nodeport
    }

    type = "NodePort"
  }
}
