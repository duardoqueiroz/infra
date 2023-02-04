variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources"
  default     = {}
}

variable "environment_vars" {
  type        = map(string)
  description = "A map of environment variables to add to the Elastic Beanstalk environment"
}

variable "key_name" {
  type        = string
  description = "The name of the key pair that should be used for the instance"
}