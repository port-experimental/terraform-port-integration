variable "installation_id" {
  type        = string
  description = "Unique identifier for this integration installation in Port."
}

variable "title" {
  type        = string
  description = "Display name for the integration in Port."
  default     = null
}

variable "installation_app_type" {
  type        = string
  description = "The integration's app type, e.g. \"linear\", \"jira\", \"github\"."
  default     = null
}

variable "installation_type" {
  type        = string
  description = "How the integration is hosted, e.g. \"Saas\" or \"OnPrem\"."
  default     = null
}

variable "spec" {
  type        = string
  description = "JSON-encoded integration spec. Pass credentials by name so their values never enter Terraform state."
  default     = null

  validation {
    condition     = var.spec == null || can(jsondecode(var.spec))
    error_message = "spec must be valid JSON — wrap the object in jsonencode()."
  }
}

variable "config" {
  type        = string
  description = "JSON-encoded mapping configuration for the integration."
  default     = null

  validation {
    condition     = var.config == null || can(jsondecode(var.config))
    error_message = "config must be valid JSON — wrap the object in jsonencode()."
  }
}