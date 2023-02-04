resource "aws_security_group" "admin_sg" {
  name = "admin_sg"
  description = "Allow SSH connection"
  egress = [{
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 0
    to_port = 0
    protocol = "-1"
    self = true
    description = "Allow all outbound traffic"
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    security_groups = []
  }]
  ingress = [{
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 22
    to_port = 22
    protocol = "tcp"
    self = false
    description = "Allow SSH connection"
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    security_groups = []
  }]

  tags = var.tags
}
