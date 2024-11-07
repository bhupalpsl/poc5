
module "my_lambda_module" {
  source = "git::https://github.com/bhupal/lambda-module.git//?ref=main"
  # Define module variables
  function_name = "my_lambda_function"
  runtime       = "python3.8"
  handler       = "index.handler"
}
