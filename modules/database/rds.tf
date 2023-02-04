
# rds
resource "aws_db_instance" "rds-app-prod" {
  allocated_storage       = 5
  engine                  = "postgres"
  engine_version          = "14.3"
  instance_class          = "db.t3.micro"
  identifier              = "eduardo-estudos-rds"
  db_name                 = var.db_name
  username                = var.username
  password                = var.password
  multi_az                = "false"
  vpc_security_group_ids  = ["${aws_security_group.rds-app-prod.id}"]
  backup_retention_period = 30
  skip_final_snapshot     = true

  tags = var.tags
}