# terraform-azurerm-static-site

Terraform module managed by the **Platform team** for provisioning a static website on Azure Storage Account.

## Usage

```hcl
module "order_portal" {
  source  = "app.terraform.io/ngphban/static-site/azurerm"
  version = "~> 1.0"

  name            = "acme-order-portal"
  environment     = "dev"
  cost_center     = "ecommerce"
  owner           = "order-team"
  index_html_path = "${path.module}/index.html"
}
```

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|----------|
| name | Application name | string | yes |
| environment | Environment (dev/test/staging/prod) | string | yes |
| cost_center | Cost center for chargeback | string | yes |
| owner | Owning team | string | yes |
| index_html_path | Path to index.html template | string | yes |
| azure_region | Azure region | string | no |
| replication_type | Storage replication type (LRS/GRS/ZRS) | string | no (default: LRS) |

## Outputs

| Name | Description |
|------|-------------|
| website_endpoint | Public URL of the static website |
| bucket_name | Storage account name |

## Versioning

| Version | Changes |
|---------|---------|
| 1.0.0 | Initial release — Azure Storage static website with templatefile support |
| 1.1.0 | Add `replication_type` variable (default LRS) — non-breaking |
