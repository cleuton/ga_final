# Configure o provedor Kubernetes
provider "kubernetes" {
  config_path        = "~/.kube/config"  # Caminho para o arquivo de configuração do kubectl
}

# Configura o backend para armazenar o estado do terraform
terraform {
  backend "kubernetes" {
    secret_suffix    = "state-python"
    config_path      = "~/.kube/config"
  }
}

module "python_app" {
  source       = "./modules/python_app"
  app_name     = "minha-app-python"
  app_image    = "cleutonsampaio/pythondemo:latest"
  app_port     = 5000
  database_password = module.postgres_db.db_password
  service_port = 5000
  service_type = "NodePort"
}

module "postgres_db" {
  source       = "./modules/postgres_db"
  db_name      = "postgres"
  db_user      = "postgres"
  db_password  = "password"
  pvc_name     = "meu-postgres-pvc"
}