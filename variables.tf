# variables.tf

variable "aws_region" {
  description = "The name of region"
  type        = string
  default     = "us-east-1"
}

variable "lambda_function_name" {
  description = "The name of the Lambda function"
  type        = string
  #default     = "my_lambda_function"
}

variable "lambda_runtime" {
  description = "The runtime for the Lambda function"
  type        = string
  default     = "python3.9"  # Adjust to your Lambda runtime, e.g., , nodejs18.x
}

variable "lambda_handler" {
  description = "The handler function for Lambda"
  type        = string
  #default     = "lambda_function.lambda_handler"  # Adjust to your function's handler, e.g., main.handler for Python
}

variable "lambda_memory_size" {
  description = "Amount of memory in MB your Lambda Function can use"
  type        = number
  default     = 128
}

variable "lambda_timeout" {
  description = "Maximum execution time in seconds for the Lambda function"
  type        = number
  default     = 10
}

variable "lambda_s3_bucket" {
  description = "S3 bucket for Lambda code storage (if applicable)"
  type        = string
  #default     = "mybucket6011"  # Leave empty if uploading locally
}

variable "lambda_s3_key" {
  description = "S3 key for Lambda code storage (if applicable)"
  type        = string
  #default     = "lambda_function.zip"  # Leave empty if uploading locally
}
variable "s3_object_version" {
  description = "S3 object "
  type        = string
  #default     = "lambda_function.zip"  # Leave empty if uploading locally
}
