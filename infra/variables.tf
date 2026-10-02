variable "aws_region" {
  description = "AWS region where resources will be created."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name used for resource naming and tagging."
  type        = string
  default     = "terraform-catalogue-api"
}

variable "environment" {
  description = "Deployment environment name."
  type        = string
  default     = "dev"
}

variable "table_name" {
  description = "Name of the DynamoDB table that stores Terraform module metadata."
  type        = string
  default     = "terraform-catalogue-modules"
}

variable "lambda_function_name" {
  description = "Name of the Lambda function that handles API requests."
  type        = string
  default     = "terraform-catalogue-api-handler"
}

variable "log_retention_days" {
  description = "Number of days to retain Lambda logs in CloudWatch."
  type        = number
  default     = 1
}