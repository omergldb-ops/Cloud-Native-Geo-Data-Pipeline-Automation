variable "vpc_id" {
  type        = string
  description = "The VPC ID where the DB will be deployed"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for the DB subnet group"
}

variable "db_password" {
  type      = string
  sensitive = true

  validation {
    condition     = length(var.db_password) >= 6 
    error_message = "The DB password must be at least 6 characters long."
  }
}
}