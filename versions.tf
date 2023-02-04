terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }
  backend "s3" {
    region = "us-east-1"
    bucket = "terraform-states-lisbom"
    key    = "estudos-eduardo/prod/terraform.tfstate"
  }

  required_version = ">= 0.14"
}