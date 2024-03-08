output "ec2_sg_id" {
  value = aws_security_group.https_sg.id
}

output "ec2_instance_id" {
  value = aws_instance.web_server.id
}
