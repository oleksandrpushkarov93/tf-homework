output "db_endpoint" {
  value = aws_db_instance.aws_db_instance.endpoint
}
output "security_group_id" {
  value = aws_security_group.allow_mysql.id
  
}


