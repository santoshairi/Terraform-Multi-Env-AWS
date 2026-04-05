

resource "aws_s3_bucket" "remote-testbucket" {
    bucket = "my-terra-bucket09"

    tags = {
        Name = "my-terra-bucket09"
    }
}

resource "aws_dynamodb_table" "remote-dynamodb-table" {
    name         = "terra-remote-table"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "LockID"

    attribute {
      name = "LockID"
      type = "S"
    }

  
}
