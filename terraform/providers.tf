provider "aws" {
  region                      = var.aws_region
  access_key                  = var.localstack_dummy
  secret_key                  = var.localstack_dummy
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    s3          = var.localstack_endpoint
    iam         = var.localstack_endpoint
    ec2         = var.localstack_endpoint
    # vpc         = var.localstack_endpoint
  }
}