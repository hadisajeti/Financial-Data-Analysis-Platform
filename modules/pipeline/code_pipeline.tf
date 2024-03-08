resource "aws_s3_bucket" "codepipeline_artifacts" {
  bucket = "ha-codepipeline-artifacts"
  acl    = "private"
}

resource "aws_s3_bucket_policy" "codepipeline_artifacts_policy" {
  bucket = aws_s3_bucket.codepipeline_artifacts.bucket

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Action": "s3:*",
      "Resource": "${aws_s3_bucket.codepipeline_artifacts.arn}/*"
    }
  ]
}
EOF
}

resource "aws_iam_role" "codepipeline_role" {
  name = "codepipeline-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "codepipeline_attach" {
  policy_arn = "arn:aws:iam::aws:policy/AWSCodePipeline_FullAccess"
  role       = aws_iam_role.codepipeline_role.name
}

resource "aws_iam_role_policy_attachment" "codecommit_attach" {
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeCommitPowerUser"
  role       = aws_iam_role.codepipeline_role.name
}

resource "aws_iam_policy" "codecommit_policy" {
  name        = "codecommit-policy"
  description = "IAM policy for CodeCommit access"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "codecommit:*"
      ],
      "Resource": "arn:aws:codecommit:eu-central-1:888659321129:financial-data-analysis-platform"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "codecommit_policy_attach" {
  policy_arn = aws_iam_policy.codecommit_policy.arn
  role       = aws_iam_role.codepipeline_role.name
}

resource "aws_codepipeline" "my_pipeline" {
  name     = "my-codepipeline"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = aws_s3_bucket.codepipeline_artifacts.bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "SourceAction"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = ["SourceOutput"]

      configuration = {
        RepositoryName = "financial-data-analysis-platform"
        BranchName     = "master"
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name     = "DeployAction"
      category = "Deploy"
      owner    = "AWS"
      provider = "CodeDeploy"
      version  = "1"

      input_artifacts = ["SourceOutput"]

      configuration = {
        ApplicationName     = "my-codedeploy-app"
        DeploymentGroupName = "my-codedeploy-group"
      }
    }
  }
}
