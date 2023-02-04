output "db_url" {
  value = aws_db_instance.rds-app-prod.endpoint
}

output "db_username" {
  value = aws_db_instance.rds-app-prod.username
}

output "db_password" {
  value = aws_db_instance.rds-app-prod.password
}

output "db_name" {
  value = aws_db_instance.rds-app-prod.db_name
}

output "db_port" {
  value = aws_db_instance.rds-app-prod.port
}

output "db_host" {
  value = aws_db_instance.rds-app-prod.address
}
