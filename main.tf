data "aws_caller_identity" "current" {}

# A wrapper on top of the provided CloudFormation stack
# https://www.terraform.io/docs/providers/aws/r/cloudformation_stack.html
resource "aws_cloudformation_stack" "datadog_aws_integration" {
  name         = "datadog-aws-integration"
  capabilities = ["CAPABILITY_IAM", "CAPABILITY_NAMED_IAM", "CAPABILITY_AUTO_EXPAND"]
  parameters = {
    APIKey                         = var.dd_api_key
    APPKey                         = var.dd_app_key
    InstallLambdaLogForwarder      = false
    CloudSecurityPostureManagement = false
  }
  template_url = var.api_stack_template_url

  tags = var.tags_api_stack
}

# Store Datadog API key in AWS Secrets Manager

resource "aws_secretsmanager_secret" "dd_api_key" {
  name        = "datadog_api_key"
  description = "Encrypted Datadog API Key"

  tags = var.tags_api_stack
}

resource "aws_secretsmanager_secret_version" "dd_api_key" {
  secret_id     = aws_secretsmanager_secret.dd_api_key.id
  secret_string = var.dd_api_key
}

# Datadog Forwarder to ship logs from S3 and CloudWatch, as well as observability data from Lambda functions to Datadog.
# https://github.com/DataDog/datadog-serverless-functions/tree/master/aws/logs_monitoring
resource "aws_cloudformation_stack" "datadog_forwarder" {
  name         = "datadog-forwarder"
  capabilities = ["CAPABILITY_IAM", "CAPABILITY_NAMED_IAM", "CAPABILITY_AUTO_EXPAND"]
  parameters = {
    # TODO: Using a data resource, pull in the dd_api_key. This is too coupled.
    DdApiKeySecretArn   = aws_secretsmanager_secret_version.dd_api_key.arn,
    ReservedConcurrency = var.lambda_forwarder_reserved_concurrency,
  }

  template_url = var.lambda_forwarder_stack_template_url

  tags = var.tags_log_forwarder
}

resource "datadog_integration_aws_lambda_arn" "main_collector" {
  account_id = data.aws_caller_identity.current.account_id
  lambda_arn = aws_cloudformation_stack.datadog_forwarder.outputs["DatadogForwarderArn"]
}

resource "datadog_integration_aws_log_collection" "main" {
  account_id = data.aws_caller_identity.current.account_id
  services   = var.log_collection_aws_services

  depends_on = [
    aws_cloudformation_stack.datadog_forwarder
  ]
}
