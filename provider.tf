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



resource "aws_s3_bucket_object" "object" {
  bucket =  var.lambda_s3_bucket
  key    =  var.lambda_s3_key
  source =  "lambda_function.zip"                         #"path/to/file"     

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
   etag = filemd5("lambda_function.zip")
}


output "s3_object_etag" {
  value = aws_s3_bucket_object.object.etag
}


output "s3_object_version" {
  value = aws_s3_bucket_object.object.version_id
}