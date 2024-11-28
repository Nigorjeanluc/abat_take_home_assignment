variable "environment" {
  description = "Environment name"
  type        = string
}

variable "namespace" {
  description = "Namespace for the deployment"
  type        = string
}

variable "nodeport" {
  description = "NodePort for the service"
  type        = number
}
