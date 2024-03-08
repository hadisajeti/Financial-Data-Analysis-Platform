provider "aws" {
  region = "eu-central-1"
}

terraform {
  backend "s3" {
    bucket = "financial-h-pipeline-tfstate"
    key    = "terraform.tfstate"
    region = "eu-central-1"

    encrypt = true
  }
}