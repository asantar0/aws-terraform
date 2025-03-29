output "s3_bucket_id" {
  description = "The name of the bucket."
  value       = aws_s3_bucket.my-first-bucket.id
  sensitive   = false
}

output "s3_bucket_bucket_domain_name" {
  description = "The bucket domain name. Will be of format bucketname.s3.amazonaws.com."
  value       = aws_s3_bucket.my-first-bucket.bucket_domain_name
  sensitive   = false
}

output "s3_bucket_policy" {
  description = "The policy of the bucket, if the bucket is configured with a policy. If not, this will be an empty string."
  value       = aws_s3_bucket.my-first-bucket.policy
  sensitive   = false
}

output "s3_bucket_region" {
  description = "The AWS region this bucket resides in."
  value       = aws_s3_bucket.my-first-bucket.region
  sensitive   = false
}
