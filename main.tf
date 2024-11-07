resource "aws_lambda_function" "my_lambda" {
  function_name = var.lambda_function_name
  handler       = var.lambda_handler     #lambda_function.lambda_handler
  runtime       = var.lambda_runtime
  role          = aws_iam_role.lambda_exec_role.arn
  memory_size   = var.lambda_memory_size
  timeout       = var.lambda_timeout
  s3_bucket     = var.lambda_s3_bucket   # Use this when uploading zip from s3 bucket
  s3_key       = var.lambda_s3_key       # Use this when uploading zip from s3 bucket
  # Environment variables (optional)
  environment {
    variables = {
      EXAMPLE_VAR = "example_value"
    }
  }
}

