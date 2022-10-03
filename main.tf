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
  template_url = "https://datadog-cloudformation-template-quickstart.s3.amazonaws.com/aws/main_v2.yaml"

  tags = {
    app     = "datadog"
    service = "api-stack"
  }
}

# Store Datadog API key in AWS Secrets Manager

resource "aws_secretsmanager_secret" "dd_api_key" {
  name        = "datadog_api_key"
  description = "Encrypted Datadog API Key"

  tags = {
    app     = "datadog"
    service = "api-stack"
  }
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
    DdApiKeySecretArn   = aws_secretsmanager_secret_version.dd_api_key.arn,
    ReservedConcurrency = var.lambda_forwarder_reserved_concurrency,
  }

  template_url = "https://datadog-cloudformation-template.s3.amazonaws.com/aws/forwarder/latest.yaml"

  tags = {
    app     = "datadog"
    service = "log-forwarder"
  }
}
