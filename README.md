# terraform-port-integration

Creates a Port integration installation with the `port_integration` resource. It deliberately contains no provider configuration or credentials; callers supply both from their root module.

> [!CAUTION]
> **Credentials** Do not pass secret values through this module. Anything supplied in `spec` is written to Terraform state in plain text, readable by anyone with access to the state file or to a plan derived from it, regardless of whether the variable is marked `sensitive`. Reference a credential by name so that Terraform only directs the integration at Port's internal credentials store, and manage the credential itself externally.

## Requirements

- Terraform >= 1.16
- `port-labs/port-labs` provider >= 2.28.0
- A root module that configures the Port provider with pipeline environment variables `PORT_CLIENT_ID` and `PORT_CLIENT_SECRET`

## Usage

```hcl
module "integration" {
  source = "github.com/port-experimental/terraform-port-integration?ref=1.0.0"

  title                 = "Linear"
  installation_id       = "linear-prod"
  installation_app_type = "linear"
  installation_type     = "Saas"

  spec = jsonencode({
    integrationSpec = {
      linearApiKey = var.linear_api_key_name
    }
  })

  config = jsonencode(local.integration_mapping)
}
```

`spec` and `config` are JSON-encoded objects. Define the mapping in the calling root module and pass it through `jsonencode`; both are validated with `jsondecode` so malformed JSON fails at plan time rather than at sync time.

`linear_api_key_name` is the name of a credential in Port, not the key itself:

```hcl
variable "linear_api_key_name" {
  type        = string
  description = "Name of the credential in Port's internal credentials store holding the Linear API key."
  default     = "linear-api-key"
}
```

Create the credential out of band — through the Port UI, API, or an existing secrets workflow — and reference it here.

## Inputs

- `installation_id` — Unique identifier for the integration installation in Port. Required.
- `title` — Title displayed in Port. Optional; defaults to `null`.
- `installation_app_type` — The integration's app type, such as `linear`, `jira` or `github`. Optional; defaults to `null`.
- `installation_type` — How the integration is hosted, such as `Saas` or `OnPrem`. Optional; defaults to `null`.
- `spec` — Optional JSON-encoded integration spec. Pass credentials by name only.
- `config` — Optional JSON-encoded mapping configuration.

## Outputs

- `id` — Port's internal identifier for the integration resource.
- `installation_id` — Installation identifier of the integration.
- `title` — Title displayed in Port.
- `installation_app_type` — App type of the integration.
- `installation_type` — Hosting type of the integration.
- `config` — Mapping configuration applied to the integration.

`spec` is not exported. It is the field most likely to carry credential references, and outputs propagate into state and into any consuming module. Add it with `sensitive = true` if a downstream module needs it.
