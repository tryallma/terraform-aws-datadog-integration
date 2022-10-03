# Datadog AWS Integration Module

## Usage

```terraform
module "elasticache" {
  source  = "app.terraform.io/allma/datadog-integration/aws"
  version = "0.1.0"

  subnet_ids = var.subnet_ids
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.5 |