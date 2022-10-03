variable "aws_region" {
  description = "AWS Region code. For more info see https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.html#concepts-available-regions"
  type        = string
  default     = "us-east-2"
  validation {
    condition = contains(
      ["us-east-1", "us-east-2"], var.aws_region
    )
    error_message = "Unsupported Allma AWS Region."
  }
}

variable "tf_cloud_aws_role_arn" {
  description = "The Allma Terraform Cloud Workspace will assume this role in the AWS account"
  type        = string

  validation {
    condition = can(
      regex("^arn:aws:iam::[[:digit:]]{12}:role/[\\w+=,.@-]{1,64}$", var.tf_cloud_aws_role_arn)
    )
    error_message = "Must be a valid AWS IAM Role ARN per https://docs.aws.amazon.com/IAM/latest/APIReference/API_CreateRole.html."
  }
}

# Find your api key from https://app.datadoghq.com/account/settings#api
# Run `export TF_VAR_dd_api_key=<ACTUAL_DD_API_KEY>` to set its value.
variable "dd_api_key" {
  type        = string
  description = "Datadog API key"
}

variable "dd_app_key" {
  type        = string
  description = "Datadog APP key"
}

variable "lambda_forwarder_reserved_concurrency" {
  type        = number
  description = "Datadog lambda reserved concurrency. See AWS Lambda docs for more info: https://docs.aws.amazon.com/lambda/latest/dg/configuration-concurrency.html"
  default     = 100
}
