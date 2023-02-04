output "instance_ip" {
  value = aws_instance.web.public_ip
}

output "instance_url" {
  value = aws_instance.web.public_dns
}