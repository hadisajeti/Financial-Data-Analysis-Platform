resource "aws_s3_bucket" "state_bucket" {
  bucket        = "financial-iac-state"
  acl           = "private"
  force_destroy = true
}