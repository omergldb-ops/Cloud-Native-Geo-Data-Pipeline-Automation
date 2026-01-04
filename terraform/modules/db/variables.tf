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
    # שים לב: בתוך condition משתמשים ב-self או בשם המשתנה בלי var.
    condition     = length(var.db_password) >= 8
    error_message = "The DB password must be at least 8 characters long."
  }
}