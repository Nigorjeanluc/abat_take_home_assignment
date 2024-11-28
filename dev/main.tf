# Main file for the dev environment
provider "kubernetes" {
  config_path = "~/.kube/config"  # Path to kubeconfig for Minikube
}

# Create a namespace for the dev environment
resource "kubernetes_namespace" "dev" {
  metadata {
    name = var.environment
  }
}

# Use the Nginx module
module "nginx" {
  source     = "../modules/nginx"
  environment = var.environment
  namespace   = kubernetes_namespace.dev.metadata[0].name
  nodeport    = var.nginx_nodeport
}

# Use the URL Shortener module
module "url_shortener" {
  source     = "../modules/url_shortener"
  environment = var.environment
  namespace   = kubernetes_namespace.dev.metadata[0].name
  nodeport    = var.url_shortener_nodeport
}

# Define Ingress for both services
resource "kubernetes_ingress_v1" "services" {
  metadata {
    name      = "dev-ingress"
    namespace = kubernetes_namespace.dev.metadata[0].name
  }

  spec {
    rule {
      http {
        path {
          path      = "/"  # This path should be unique to each service
          path_type = "Prefix"  # Make sure you're using API v1 and that path_type is supported

          backend {
            service {
              name = module.nginx.service_name
              port {
                number = 80
              }
            }
          }
        }

        path {
          path      = "/"  # This path should be unique to each service
          path_type = "Prefix"  # Same here, check the API version compatibility

          backend {
            service {
              name = module.url_shortener.service_name
              port {
                number = 8080
              }
            }
          }
        }
      }
    }
  }
}
