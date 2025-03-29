resource "aws_s3_bucket" "my-first-bucket" {
  bucket = "my-first-bucket-ros-sf"

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