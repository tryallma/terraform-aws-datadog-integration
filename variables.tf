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

variable "api_stack_template_url" {
  type        = string
  description = "URL to Datadog API Stack CloudFormation template"
  default     = "https://datadog-cloudformation-template-quickstart.s3.amazonaws.com/aws/main_v2.yaml"
}

variable "lambda_forwarder_stack_template_url" {
  type        = string
  description = "URL to Datadog Lambda Forwarder Stack CloudFormation template"
  default     = "https://datadog-cloudformation-template.s3.amazonaws.com/aws/forwarder/latest.yaml"
}
