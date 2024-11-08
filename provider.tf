provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket         = "mybucket6011"
    key            = "lambda-module/terraform.tfstate"
    region         = "us-east-1"
    #dynamodb_table = "terraform-lock-table2"    # Replace with your DynamoDB table name
    #encrypt        = true                      # Enable server-side encryption for state file
}

}