variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources"
  default     = {}
}

variable "environment_vars" {
  type        = map(string)
  description = "A map of environment variables to add to the Elastic Beanstalk environment"
}

variable "gh_owner" {
  type = string
  description = "The owner of the GitHub repository"
}

variable "gh_repo" {
  type = string
  description = "The name of the GitHub repository"
}

variable "gh_token" {
  type = string
  description = "The GitHub token to access the repository"
}