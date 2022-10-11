# Datadog AWS Integration Module

## Introduction

This Terraform module deploys the necessary AWS resources to support Datadog monitoring in a given AWS account.

## Usage

```terraform
module "datadog_integration" {
  source  = "app.terraform.io/allma/datadog-integration/aws"
  version = "~> 0.3"

  dd_api_key = "<Datadog API Key"
  dd_app_key = "<Datadog Application Key>"
  lambda_forwarder_reserved_concurrency = 10
}
```

## Requirements

| Name | Version |
|------|---------|
| [Terraform](https://www.terraform.io/)| >= [1.1.1](https://github.com/hashicorp/terraform/blob/v1.1/CHANGELOG.md) |

## Providers

| Name | Version |
|------|---------|
| [hashicorp/aws](https://registry.terraform.io/providers/hashicorp/aws/latest/docs) | >= 4.5 |
| [Datadog/datadog](https://registry.terraform.io/providers/DataDog/datadog/latest/docs) | >= 3.0 |
