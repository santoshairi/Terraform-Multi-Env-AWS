resource "aws_s3_bucket" "my-s3-bucket" {
  bucket = var.bucket_name
  tags   = var.tags
}

resource "aws_s3_bucket_versioning" "my-s3-bucket" {
  bucket = aws_s3_bucket.my-s3-bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}