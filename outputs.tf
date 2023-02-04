output "instance_ip" {
  value = module.admin.instance_ip
}

output "private_key" {
  value = nonsensitive(tls_private_key.keys.private_key_pem)
}

output "instance_url" {
  value = module.admin.instance_url
}
