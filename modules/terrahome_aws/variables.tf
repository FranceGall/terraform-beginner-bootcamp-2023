
# Variable definition and validation
variable "user_uuid" {
  description = "User UUID"
  type        = string
  
  validation {
    condition     = can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", var.user_uuid))
    error_message = "User UUID must be in the format of a UUID (e.g., 123e4567-e89b-12d3-a456-426655440000)"
  }
}
#variable "bucket_name" {
#  description = "Name of S3 bucket"
#  type        = string
#
#  validation {
#    condition     = (
#    length(var.bucket_name) >= 3 && length(var.bucket_name) <= 63 &&
#    can(regex("^([a-zA-Z0-9.-]{3,63})$", var.bucket_name))
#    )
#    error_message = "It must be 3-63 characters long and can only contain letters, numbers, hyphens, and periods."
#  }
#}


variable "content_version" {
  description = "The content version. Should be a positive integer starting at 1."
  type        = number

  validation {
    condition     = var.content_version > 0 && floor(var.content_version) == var.content_version
    error_message = "The content_version must be a positive integer starting at 1."
  }
}
variable "public_path" {
  description = "The file path for the public directory"
  type        = string
}