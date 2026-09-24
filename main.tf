resource "port_integration" "main" {
  title                 = var.title
  installation_id       = var.installation_id
  installation_app_type = var.installation_app_type
  installation_type     = var.installation_type


  spec      = var.spec
  config    = var.config
}
