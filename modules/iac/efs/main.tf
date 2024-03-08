resource "aws_efs_file_system" "shared_efs" {
  creation_token = "my-efs"

  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
  }

  tags = {
    Name        = "MyEFS"
    Environment = "Production"
  }
}

resource "aws_security_group" "efs_sg" {
  vpc_id      = var.vpc_id
  name        = "efs_sg"
  description = "EFS Security Group"

  ingress {
    from_port       = 2049
    to_port         = 2049
    protocol        = "tcp"
    security_groups = [var.security_group_ids]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_efs_mount_target" "efs_mount" {
  file_system_id  = aws_efs_file_system.shared_efs.id
  subnet_id       = var.public_subnet_id
  security_groups = [aws_security_group.efs_sg.id]
}

output "efs_dns_name" {
  value = aws_efs_file_system.shared_efs.dns_name
}
