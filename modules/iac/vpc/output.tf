output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}

output "private_subnet_id" {
  value = aws_subnet.private_subnet.id
}
output "vpc_id"{
  value = aws_vpc.my_vpc.id
}
output "private_subnet_id_c" {
  value = aws_subnet.private_subnet_c.id
}