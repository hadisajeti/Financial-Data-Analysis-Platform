variable "desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in the group."
  type        = number
}

variable "max_size" {
  description = "The maximum size of the Auto Scaling group."
  type        = number
}

variable "min_size" {
  description = "The minimum size of the Auto Scaling group."
  type        = number
}

variable "subnet_id" {
  description = "The VPC subnet IDs."
  type        = string
}

variable "image_id" {
  description = "The EC2 image ID to use."
  type        = string
}

variable "instance_type" {
  description = "The instance type of the EC2 instances."
  type        = string
}