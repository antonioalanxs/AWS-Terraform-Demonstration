variable "aws_region" {
  description = "Amazon Web Services (AWS) region"
  type        = string
  default     = "eu-west-1"
}

variable "localstack_endpoint" {
  description = "LocalStack endpoint"
  type        = string
}

variable "localstack_dummy" {
  description = "Dummy credentials for LocalStack"
  type        = string
  default     = "test"
}


variable "instance_type" {
  description = "Amazon EC2 instance type"
  type        = string
}

variable "ami" {
  description = "Amazon Machine Image (AMI) identifier"
  type        = string
}

variable "name" {
  description = "Amazon EC2 instance name"
  type        = string
}
