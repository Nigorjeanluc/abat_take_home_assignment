variable "environment" {
  description = "dev"
  type        = string
}

variable "nginx_nodeport" {
  description = "NodePort for Nginx in dev environment"
  type        = number
}

variable "url_shortener_nodeport" {
  description = "NodePort for URL Shortener in dev environment"
  type        = number
}
