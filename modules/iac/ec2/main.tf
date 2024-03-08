resource "aws_security_group" "https_sg" {
  name        = "https_sg"
  description = "Allow inbound traffic on port 443"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web_server" {
  ami           = var.ec2_ami
  instance_type = "t3.micro"
  subnet_id     = var.public_subnet_id

  vpc_security_group_ids = [
    aws_security_group.https_sg.id,
  ]

  tags = {
    Name = "WebServer"
  }
}