# Financial Data Analysis Infrastructure

## AWS Resources

### VPC
- Segregated public and private subnets for enhanced security and scalability.
- NAT Gateway for secure internet access in the private subnet.

### S3
- Used for storing course materials and videos.

### EC2
- Application servers running on t3.micro instances in the public subnet.

### RDS
- MySQL engine running on db.t3.micro instances in the private subnet.
- Daily backups retained for 7 days.

### DynamoDB
- Used for course progress tracking.

### EFS
- Elastic File System for shared resources among students.

### CloudWatch
- Monitoring system and application health.
- Logs retained for 1 week.

### Autoscaling Group
- Minimum 1 instance, maximum 2 instances.
- Scaling based on both CPU and memory utilization (> 70%).

### Load Balancer
- Application Load Balancer in the public subnet.

### Bastion Host
- t3.micro EC2 instance for secure access.

## Specific Technical Requirements

### Security
- Security Group for application servers allowing HTTPS (443).
- NACLs with custom rules for enhanced security.
- Security Group for Bastion Host allowing SSH (22) access from your IP address.

### Autoscaling
- Minimum 1 instance, maximum 2 instances.
- Autoscaling based on both CPU and memory utilization (> 70%).

### Monitoring & Log Retention
- CloudWatch for monitoring system and application health.
- Logs retained for 1 week.

### Database Backup
- RDS MySQL with daily backups, retaining for 7 days.

## Bonus Requirement
- AWS CloudTrail set up for governance, compliance, operational auditing, and risk auditing of your AWS account.

## Usage
1. Install Terraform on your local machine.
2. Clone this repository.
4. Navigate to the root directory of the cloned repository.
5. Create an S3 bucket manually to save Terraform files.
6. Run `terraform init` to initialize the Terraform configuration.
7. Run `terraform apply` to apply the infrastructure changes.
8. Execute the pipeline manually from AWS CodePipeline in the AWS Management Console.
