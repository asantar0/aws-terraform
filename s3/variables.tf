variable "bucket" {
  default     = "my-first-bucket-ros-sf"
  description = "The name of the bucket to create. If omitted, Terraform will assign a random, unique name. Conflicts with name_prefix."
  type        = string
}

##  This option enables the bucket object to transition to another lowcost storage ##
variable "enable_transition" {
  default     = true
  description = "(Optional) Information in regards to moving the data to low cost storage is required"
}

variable "s3_transition_days" {
  type        = number
  default     = 30
  description = "How long before it moves to low cost storage"
}

variable "s3_transtion_storage_class" {
  type        = string
  default     = "GLACIER"
  description = "Which storage it needs to move. i.e Glacier"
}

variable "s3_id" {
  default     = "logs"
  type        = string
  description = "It can be any meanigful name for us to identify the liefcle policy applied to Bucket"
}

variable "s3_prefix" {
  default     = "/"
  type        = string
  description = "this option enables to set the rule to specific folder/object within the bucket. / indicates all the objects within the bucket"
}

variable "s3_expired_days" {
  default     = null
  description = "Indicates if the object within bucket needs to expire. default is null so the object never expires"
}

variable "lifecycle_enabled" {
default = true
description = "Does this bucket needs any oject to either transtion to another low cost storage or needs object to be expired after some days"
}
