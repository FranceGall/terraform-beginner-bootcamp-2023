#cloud {
#  organization = "ExamProPatrick"
#  workspace {
#    name = "terra-house-superfly"
#  }
#}

#Generate random name for AWS bucket
resource "random_string" "bucket_name" {
  lower            = true
  upper            = false
  length           = 16
  special          = false
}

resource "aws_s3_bucket" "example" {
  bucket = random_string.bucket_name.result
  tags = {
    UserUuid = var.user_uuid
  }
}