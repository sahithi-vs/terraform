terraform {
  backend "s3" {
    bucket = "terraform-remote-state023"
    key    = "terraform.tfstate"
    region = "ap-southeast-1"
  }
}

resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name         = var.dynamodb_table_name 
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "LockID"
    type = "S"
  }
}