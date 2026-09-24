output "id" {
  description = "Port's internal identifier for the integration resource."
  value       = port_integration.main.id
}

output "installation_id" {
  description = "Installation identifier of the integration."
  value       = port_integration.main.installation_id
}

output "title" {
  description = "Display name of the integration in Port."
  value       = port_integration.main.title
}

output "installation_app_type" {
  description = "App type of the integration."
  value       = port_integration.main.installation_app_type
}

output "installation_type" {
  description = "Hosting type of the integration."
  value       = port_integration.main.installation_type
}

output "config" {
  description = "JSON-encoded mapping configuration applied to the integration."
  value       = port_integration.main.config
}