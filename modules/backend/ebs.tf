resource "aws_elastic_beanstalk_application" "ebs" {
  name = "eduardo-estudos-application"
  description = "Elastic Beanstalk Application for Eduardo Estudos"

  tags = local.tags
}

resource "aws_elastic_beanstalk_environment" "prod_env" {
  name = "eduardo-estudos-environment-prod"
  description = "Elastic Beanstalk Environments for Eduardo Estudos"
  application = aws_elastic_beanstalk_application.ebs.id
  solution_stack_name = "64bit Amazon Linux 2 v3.4.19 running Docker"

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "aws-elasticbeanstalk-ec2-role"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "EC2KeyName"
    value     = var.key_name
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
    for_each = var.environment_vars
    content {
      namespace = "aws:elasticbeanstalk:application:environment"
      name = setting.key
      value = setting.value
    }    
  }
}

