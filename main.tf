#cloud {
#  organization = "ExamProPatrick"
#  workspace {
#    name = "terra-house-superfly"
#  }
#}

resource "aws_s3_bucket" "website_bucket" {
  bucket = var.bucket_name
  tags = {
    UserUuid = var.user_uuid
  }
}