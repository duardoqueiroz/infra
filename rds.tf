resource "aws_security_group" "rds-app-prod" {
  name        = "rds-sg"
  description = "Allow inbound postgres traffic"

  tags = {
    "Name"= "eduardo-estudos"
  }
}

resource "aws_security_group_rule" "allow-postgres-backend" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  security_group_id        = aws_security_group.rds-app-prod.id
  source_security_group_id = aws_security_group.ebs-sg.id
}

resource "aws_security_group_rule" "allow-outgoing" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.rds-app-prod.id
  cidr_blocks       = ["0.0.0.0/0"]
}

# rds
resource "aws_db_instance" "rds-app-prod" {
  allocated_storage       = 5
  engine                  = "postgres"
  engine_version          = "14.3"
  instance_class          = "db.t3.micro"
  identifier              = "eduardo-estudos-rds"
  db_name                 = local.backend_vars.PG_DATABASE
  username                = local.backend_vars.PG_USER
  password                = local.backend_vars.PG_PASSWORD
  multi_az                = "false"
  vpc_security_group_ids  = ["${aws_security_group.rds-app-prod.id}"]
  backup_retention_period = 30
  skip_final_snapshot     = true

  tags = {
    "Name"= "eduardo-estudos"
  }
}