resource "kubernetes_config_map" "minha-app-sql-config" {
  metadata {
    name = "minha-app-sql-config"
  }

  data = {
    "init.sql" = file("${path.module}/init.sql")
  }
}

resource "kubernetes_persistent_volume_claim" "postgres_pvc" {
  metadata {
    name = var.pvc_name
  }

  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "1Gi"
      }
    }
  }
}


resource "kubernetes_stateful_set" "postgres_db" {
  metadata {
    name = "${var.db_name}-minha-app-statefulset"
  }

  spec {
    service_name = "${kubernetes_service.postgres_service.metadata[0].name}"
    replicas = var.db_replicas

    selector {
      match_labels = {
        app = var.db_name
      }
    }

    template {
      metadata {
        labels = {
          app = var.db_name
        }
      }

      spec {
        container {
          image = var.db_image
          name  = var.db_name

          port {
            container_port = var.db_port
          }

          env {
            name  = "POSTGRES_DB"
            value = var.db_name
          }

          env {
            name  = "POSTGRES_USER"
            value = var.db_user
          }

          env {
            name  = "POSTGRES_PASSWORD"
            value = var.db_password
          }

          env {
            name  = "PGDATA"
            value = "/var/lib/postgresql/data/pgdata" # Use sempre um subdiretorio (pasta lost+found)
          }

          volume_mount {
            name       = "sql-config-volume"
            mount_path = "/docker-entrypoint-initdb.d"
          }

          volume_mount {
            mount_path = "/var/lib/postgresql/data" 
            name       = "postgres-storage"
          }
        }

        volume {
          name = "sql-config-volume"

          config_map {
            name = kubernetes_config_map.minha-app-sql-config.metadata[0].name
          }
        }

        volume {
          name = "postgres-storage"

          persistent_volume_claim {
            claim_name = var.pvc_name
          }
        }
      }
    }
  }
}

/* Serviço do database */

resource "kubernetes_service" "postgres_service" {
  metadata {
    name = "db"
  }

  spec {
    selector = {
      app = var.db_name
    }

    port {
      port        = var.db_port
      target_port = var.db_port
    }
  }
}

