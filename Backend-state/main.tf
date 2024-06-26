provider "aws" {
  region = "us-east-1"

}
#  S3 bucket
resource "aws_s3_bucket" "enter-backend-state" {
  bucket = "proj1-backend-state"

  lifecycle {
    prevent_destroy = true
  }
#   versioning {
#     enabled = true
#   }
#   server_side_encryption_configuration {
#     rule {
#       apply_server_side_encryption_by_default {
#         sse_algorithm = "AES256"
#       }
#     }
#   }
}
resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.enter-backend-state.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
# locking dynamodb

resource "aws_dynamodb_table" "enterprise-backend-lock" {
  name = "dev_application_lock"
  billing_mode = "PAY_PER_REQUEST"

  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
    
  }
}