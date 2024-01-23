resource "kubernetes_deployment" "python_app" {
  metadata {
    name = "${var.app_name}-deployment"
    labels = {
      app = var.app_name
    }
  }

  spec {
    replicas = var.app_replicas

    selector {
      match_labels = {
        app = var.app_name
      }
    }

    template {
      metadata {
        labels = {
          app = var.app_name
        }
      }

      spec {
        container {
          image = var.app_image
          name  = var.app_name

          port {
            container_port = var.app_port
          }

          env {
            name  = "DB_PSW"
            value = var.database_password
          }
        }
      }
    }
  }
}

/* Serviço para app */

resource "kubernetes_service" "python_app_service" {
  metadata {
    name = "${var.app_name}-service"
  }

  spec {
    selector = {
      app = var.app_name
    }

    port {
      port        = var.service_port
      target_port = var.app_port
    }

    type = var.service_type
  }
}