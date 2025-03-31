resource "aws_s3_bucket" "my-first-bucket" {
  bucket = var.bucket

  tags = {
    Name        = "My special bucket"
    Environment = "Prod"
  }
}

resource "aws_s3_bucket_versioning" "versioning-parameters" {
  bucket = aws_s3_bucket.my-first-bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption_config" {
  bucket = var.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }
}

