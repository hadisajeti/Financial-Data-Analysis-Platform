Financial Data Analysis Platform Runbook
Overview
This runbook provides operational procedures for managing and maintaining the "Financial Data Analysis Platform." It covers various components, including the VPC infrastructure, EC2 instances, RDS databases, Auto Scaling groups, S3 buckets, IAM roles, and more. Follow the instructions below for common operational tasks.

Table of Contents
VPC and Networking
EC2 Instances
RDS Database
Auto Scaling Group
S3 Buckets
EFS (Elastic File System)
CloudWatch Alarms
CloudTrail Setup
IAM (Identity and Access Management)
CodePipeline and CodeBuild
VPC and Networking
Creating the VPC
To create and manage the VPC:

Access: Navigate to the vpc module in the iac directory.
Execution: Execute terraform init and terraform apply to create the VPC.
Outputs: Retrieve VPC ID, public subnet ID, and private subnet ID from the Terraform output.
EC2 Instances
Managing EC2 Instances
To manage EC2 instances:

Access: Navigate to the ec2 module in the iac directory.
Execution: Execute terraform init and terraform apply to manage EC2 instances.
Outputs: Retrieve EC2 Security Group ID, EC2 instance ID, and other relevant information.
RDS Database
Configuring the RDS Database
To configure and manage the RDS database:

Access: Navigate to the rds module in the iac directory.
Execution: Execute terraform init and terraform apply to configure the RDS database.
Outputs: Retrieve RDS Security Group ID, RDS instance details, and other relevant information.
Auto Scaling Group
Managing Auto Scaling Group
To manage the Auto Scaling group:

Access: Navigate to the auto_scaling module in the iac directory.
Execution: Execute terraform init and terraform apply to manage the Auto Scaling group.
Outputs: Retrieve Auto Scaling group name and related details.
S3 Buckets
Configuring S3 Buckets
To configure and manage S3 buckets:

Access: Navigate to the s3 module in the iac directory.
Execution: Execute terraform init and terraform apply to manage S3 buckets.
Outputs: Retrieve S3 bucket details and access information.
EFS (Elastic File System)
Configuring EFS
To configure and manage EFS:

Access: Navigate to the efs module in the iac directory.
Execution: Execute terraform init and terraform apply to manage EFS.
Outputs: Retrieve EFS details, DNS name, and security group information.
CloudWatch Alarms
Managing CloudWatch Alarms
To configure and manage CloudWatch Alarms:

Access: Navigate to the cloudwatch module in the iac directory.
Execution: Execute terraform init and terraform apply to manage CloudWatch Alarms.
Outputs: Retrieve CloudWatch Alarm details and relevant information.
CloudTrail Setup
Setting Up CloudTrail
To configure and manage AWS CloudTrail:

Access: Navigate to the cloudtrail module in the iac directory.
Execution: Execute terraform init and terraform apply to set up CloudTrail.
Outputs: Retrieve CloudTrail setup details and access information.
IAM (Identity and Access Management)
Managing IAM Roles
To configure and manage IAM roles:

Access: Navigate to the iam module in the iac directory.
Execution: Execute terraform init and terraform apply to manage IAM roles.
Outputs: Retrieve IAM role details and access information.
CodePipeline and CodeBuild
Managing CodePipeline and CodeBuild
To configure and manage AWS CodePipeline and CodeBuild:

Access: Navigate to the codepipeline and codebuild modules in the iac directory.
Execution: Execute terraform init and terraform apply to set up CodePipeline and CodeBuild.
Outputs: Retrieve CodePipeline and CodeBuild setup details.
