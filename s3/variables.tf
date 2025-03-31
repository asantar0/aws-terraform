variable "bucket" {
  default     = "my-first-bucket-ros-sf"
  description = "The name of the bucket to create. If omitted, Terraform will assign a random, unique name. Conflicts with name_prefix."
  type        = string
}
