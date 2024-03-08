resource "aws_security_group" "rds_sg" {
  name        = "rds-security-group"
  description = "Security group for the RDS instance"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_db_subnet_group" "db_subnet" {
  name       = "db-subnet-group"
  subnet_ids = [var.private_subnet_id,var.private_subnet_cidr_c]
}

resource "aws_db_instance" "rds_db" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  db_name              = "hadisdb"
  username             = "admin"
  password             = "password"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true

  backup_retention_period = 7
  backup_window           = "01:00-02:00"

  db_subnet_group_name    = aws_db_subnet_group.db_subnet.name

  vpc_security_group_ids = [aws_security_group.rds_sg.id]
}