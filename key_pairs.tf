resource "tls_private_key" "keys" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "key_pair" {
  key_name = "eduardo-estudos"
  public_key = tls_private_key.keys.public_key_openssh

  tags = {
    Name = "eduardo-estudos"
  }
}