resource "aws_codebuild_project" "my_codebuild_project" {
  name          = "my-codebuild-project"
  description   = "My CodeBuild Project"
  service_role  = aws_iam_role.codebuild_role.arn
  environment   {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:4.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }
  artifacts {
    type = "CODEPIPELINE"
  }
  source {
    type            = "CODEPIPELINE"
    buildspec       = file("../../modules/iac/buildspec.yaml")
  }
}

resource "aws_iam_role" "codebuild_role" {
  name = "codebuild-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}


