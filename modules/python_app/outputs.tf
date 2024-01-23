output "nodeport" {
  value = kubernetes_service.python_app_service.spec[0].port[0].node_port
}
