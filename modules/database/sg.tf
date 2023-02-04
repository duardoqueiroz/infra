resource "aws_security_group" "rds-app-prod" {
  name        = "rds-sg"
  description = "Allow inbound postgres traffic"

  tags = var.tags
}

resource "aws_security_group_rule" "allow-outgoing" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.rds-app-prod.id
  cidr_blocks       = ["0.0.0.0/0"]
}