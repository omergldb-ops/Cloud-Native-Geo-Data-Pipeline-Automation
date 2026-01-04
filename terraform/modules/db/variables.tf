variable "vpc_id" {
  type        = string
  description = "The VPC ID where the DB will be deployed"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for the DB subnet group"
}

variable "db_password" {
  type        = string
  sensitive   = true
  description = "Password for the database admin user"
}