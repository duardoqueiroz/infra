locals {
  tags = merge(var.tags, {
    "Resource" = "backend"
  }) 
}