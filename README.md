# Datadog AWS Integration Module

## Usage

```terraform
module "datadog_integration" {
  source  = "app.terraform.io/allma/datadog-integration/aws"
  version = "0.1.1"

  dd_api_key = "<Datadog API Key"
  dd_app_key = "<Datadog Application Key>"
  lambda_forwarder_reserved_concurrency = 10
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