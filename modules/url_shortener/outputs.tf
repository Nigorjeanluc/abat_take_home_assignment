# Outputs provided by the module

output "service_name" {
  value = kubernetes_service.url_shortener.metadata[0].name
}
