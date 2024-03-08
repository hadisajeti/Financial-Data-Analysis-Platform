resource "aws_s3_bucket" "governance_cloudtrail_bucket" {
  bucket = "governance-cloudtrail-logs"
  acl    = "private"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "cloudtrail.amazonaws.com"
      },
      "Action": "s3:GetBucketAcl",
      "Resource": "arn:aws:s3:::governance-cloudtrail-logs"
    },
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "cloudtrail.amazonaws.com"
      },
      "Action": "s3:PutObject",
      "Resource": "arn:aws:s3:::governance-cloudtrail-logs/*"
    }
  ]
}
POLICY
}

resource "aws_cloudtrail" "governance" {
  name           = "governance"
  s3_bucket_name = aws_s3_bucket.governance_cloudtrail_bucket.bucket
  enable_logging = true
}

