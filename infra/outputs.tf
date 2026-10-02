# dynamodb outputs
output "dynamodb_table_name" {
  description = "Name of the DynamoDB table that stores Terraform module metadata."
  value       = aws_dynamodb_table.modules.name
}

output "dynamodb_table_arn" {
  description = "ARN of the DynamoDB table that stores Terraform module metadata."
  value       = aws_dynamodb_table.modules.arn
}

#lambda outputs
#output "lambda_function_name" {
#  description = "Name of the Lambda function that handles API requests."
#  value       = aws_lambda_function.api.function_name
#}

#output "lambda_function_arn" {
#  description = "ARN of the Lambda function that handles API requests."
#  value       = aws_lambda_function.api.arn
#}

#API gateway
#output "api_endpoint" {
#  description = "Base URL of the API Gateway HTTP API."
#  value       = aws_apigatewayv2_api.catalogue.api_endpoint
#}

#cloudwatch logs
#output "lambda_log_group_name" {
#  description = "Name of the CloudWatch log group for the Lambda function."
#  value       = aws_cloudwatch_log_group.lambda.name
#}

output "api_endpoint" {
  description = "Base URL of the HTTP API"
  value       = aws_apigatewayv2_api.catalogue.api_endpoint
}