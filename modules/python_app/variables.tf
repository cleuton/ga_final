variable "app_name" {
  description = "Nome da aplicação Python"
  type        = string
}

variable "app_image" {
  description = "Docker image da aplicação Python"
  type        = string
}

variable "app_replicas" {
  description = "Número de réplicas da aplicação"
  type        = number
  default     = 2
}

variable "app_port" {
  description = "Porta do container da aplicação"
  type        = number
}

variable "database_password" {
  description = "Senha do banco de dados PostgreSQL"
  type        = string
}

variable "service_port" {
  description = "Porta do serviço Kubernetes para a aplicação Python"
  type        = number
}

variable "service_type" {
  description = "Tipo do serviço Kubernetes para a aplicação Python"
  type        = string
  default     = "NodePort"
}