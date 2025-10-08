resource "aws_db_instance" "aws_db_instance" {
  allocated_storage    = var.allocated_storage
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  username             = "admin"
  password             = "MyStrongPassword"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.allow_mysql.id]
db_subnet_group_name = aws_db_subnet_group.my_subnets.name
  
}

