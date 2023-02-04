variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources"
  default     = {}
}

variable "db_name" {
  type = string 
  description = "The name of the database to create when the DB instance is created"
}

variable "username" {
  type = string
  description = "The username for the DB user"
}

variable "password" {
  type = string
  description = "The password for the DB user"
}