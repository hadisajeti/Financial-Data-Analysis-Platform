resource "aws_s3_bucket" "financial" {
  bucket        = "financial-data-ha"
  acl           = "private"
  force_destroy = true

  tags = {
    Name        = "FinancialS3Bucket"
    Environment = "Production"
  }
}