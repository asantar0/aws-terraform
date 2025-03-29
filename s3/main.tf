resource "aws_s3_bucket" "my-first-bucket" {
  bucket = "my-first-bucket-ros-sf"

  tags = {
    Name        = "My special bucket"
    Environment = "Prod"
  }
}