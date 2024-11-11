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


# Permission for S3 to invoke Lambda
resource "aws_lambda_permission" "allow_s3_invoke" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.my_lambda.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = "arn:aws:s3:::mybucket6011"
}


# S3 Bucket Notification to invoke Lambda
resource "aws_s3_bucket_notification" "s3_to_lambda" {
  bucket = var.lambda_s3_bucket 

  lambda_function {
    lambda_function_arn = aws_lambda_function.my_lambda.arn
    events              = ["s3:ObjectCreated:*"]  # Trigger on object creation
  }

  depends_on = [aws_lambda_permission.allow_s3_invoke]
}

