output "instance_ip" {
  value = aws_instance.web.public_ip
}

output "private_key" {
  value = nonsensitive(tls_private_key.keys.private_key_pem)
}

output "instance_url" {
  value = aws_instance.web.public_dns
}
