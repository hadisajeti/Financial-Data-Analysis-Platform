provider "aws" {
  region = "eu-central-1"
}

terraform {
  backend "s3" {
    bucket = "financial-h-iac-tfstate"
    key    = "terraform.tfstate"
    region = "eu-central-1"

    encrypt = true
  }
}

module "vpc" {
  source = "./vpc"
}

module "s3" {
  source = "./s3"
}

module "dynamo_db" {
  source = "./dynamo_db"
}

module "bastion" {
  source           = "./bastion"
  public_subnet_id = module.vpc.public_subnet_id
}

module "ec2" {
  source           = "./ec2"
  public_subnet_id = module.vpc.public_subnet_id
  vpc_id = module.vpc.vpc_id
}

module "rds" {
  source            = "./rds"
  vpc_id            = module.vpc.vpc_id
  bastion_sg_id     = module.bastion.bastion_sg_id
  private_subnet_id = module.vpc.private_subnet_id
  private_subnet_cidr_c = module.vpc.private_subnet_id_c
}


module "efs" {
  source             = "./efs"
  public_subnet_id   = module.vpc.public_subnet_id
  security_group_ids = module.ec2.ec2_sg_id
  vpc_id = module.vpc.vpc_id
}

module "auto_scaling" {
  source           = "./auto_scaling"
  subnet_id        = module.vpc.public_subnet_id
  max_size         = 2
  min_size         = 1
  image_id         = "ami-03484a09b43a06725"
  instance_type    = "t3.micro"
  desired_capacity = 1
}

module "cloudwatch" {
  source             = "./cloudwatch"
  InstanceId         = module.ec2.ec2_instance_id
  sns_topic_arn            = module.sns.sns_topic_arn
  load_balancer_name = module.load_balancer.load_balancer_name
}

module "sns" {
  source = "./sns"
}

module "load_balancer" {
  source           = "./load_balancer"
  vpc_id           = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnet_id
  private_subnet_id = module.vpc.private_subnet_id
  ec2_instance_id  = module.ec2.ec2_instance_id
}

module "cloudtrail" {
  source = "./cloudtrail"
}

module "s3_state" {
  source = "./s3_state"
}