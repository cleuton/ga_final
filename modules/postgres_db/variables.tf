variable "db_name" {
  description = "Nome do banco de dados PostgreSQL"
  type        = string
}

variable "db_image" {
  description = "Docker image do PostgreSQL"
  type        = string
  default     = "postgres:latest"
}

variable "db_replicas" {
  description = "Número de réplicas do banco de dados"
  type        = number
  default     = 1
}

variable "db_port" {
  description = "Porta do container do banco de dados"
  type        = number
  default     = 5432
}

variable "db_user" {
  description = "Usuário do banco de dados"
  type        = string
}

variable "db_password" {
  description = "Senha do banco de dados"
  type        = string
}

variable "pvc_name" {
  description = "Nome do Persistent Volume Claim para armazenamento do banco de dados"
  type        = string
}
