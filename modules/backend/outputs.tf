output "ebs_url" {
  value = aws_elastic_beanstalk_environment.prod_env.endpoint_url
}