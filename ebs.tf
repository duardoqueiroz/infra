resource "aws_elastic_beanstalk_application" "ebs" {
  name = "eduardo-estudos-application"
  description = "Elastic Beanstalk Application for Eduardo Estudos"

  tags = {
    "Name" = "eduardo-estudos"
  }
}

resource "aws_security_group" "ebs-sg" {
  name = "ebs-sg"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_elastic_beanstalk_environment" "prod_env" {
  name = "eduardo-estudos-environment-prod"
  description = "Elastic Beanstalk Environments for Eduardo Estudos"
  application = aws_elastic_beanstalk_application.ebs.id
  solution_stack_name = "64bit Amazon Linux 2 v3.4.19 running Docker"
  depends_on = [
    aws_security_group.ebs-sg
  ]

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "aws-elasticbeanstalk-ec2-role"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "EC2KeyName"
    value     = aws_key_pair.key_pair.key_name
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = "t2.micro"
  }

  setting {
    namespace = "aws:cloudformation:template:parameter"
    name = "InstanceTypeFamily"
    value = "t2"
  }

  dynamic "setting" {
    for_each = merge({ for k, v in local.backend_vars : k => v if !contains(keys(local.computed_vars), k)}, local.computed_vars)
    content {
      namespace = "aws:elasticbeanstalk:application:environment"
      name = setting.key
      value = setting.value
    }    
  }
}

locals {
  computed_vars = {
    PG_HOST = aws_db_instance.rds-app-prod.address
    PG_PORT = aws_db_instance.rds-app-prod.port
    AWS_S3_BUCKET = aws_s3_bucket.file-storage.bucket
    AWS_ACCESS_KEY_ID = aws_iam_access_key.file-storage.id
    AWS_SECRET_ACCESS_KEY = aws_iam_access_key.file-storage.secret
  }
}