#Basic S3 information in order to create it
resource "aws_s3_bucket" "my-first-bucket" {
  bucket = var.bucket

  tags = {
    Name        = "My special bucket"
    Environment = "Prod"
  }
}

#Versioning status
resource "aws_s3_bucket_versioning" "versioning-parameters" {
  bucket = aws_s3_bucket.my-first-bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

#Encryption Options
resource "aws_s3_bucket_server_side_encryption_configuration" "encryption_config" {
  bucket = var.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "s35" {
  count  = var.lifecycle_enabled ? 1 : 0
  bucket = var.bucket
  rule {
    id = var.s3_id
    filter {
      prefix = var.s3_prefix
    }
    expiration {
      days = var.s3_expired_days
    }
    status = "Enabled"
    dynamic "transition" {
      for_each = var.enable_transition ? [1] : []
      content {
        days          = var.s3_transition_days
        storage_class = var.s3_transtion_storage_class
      }
    }
  }
}

