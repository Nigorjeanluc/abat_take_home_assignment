# Input variables for the module

variable "environment" {
  description = "prod"
  type        = string
}

variable "namespace" {
  description = "Namespace for the deployment"
  type        = string
}

variable "nodeport" {
  description = "NodePort for the URL Shortener service"
  type        = number
}
