variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
  description = "CIDR block for the VPC"
}

variable "private_subnet_count" {
  type        = number
  default     = 2
  description = "Number of private subnets to create when `private_subnet_cidrs` is not provided"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  default     = []
  description = "Optional list of CIDR blocks for private subnets. If non-empty, these will be used instead of auto-calculated CIDRs."
}

variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
  description = "Availability zones to place subnets in; length should match private subnet count when providing explicit cidrs."
}

variable "private_subnet_start_index" {
  type        = number
  default     = 10
  description = "Starting network number within the VPC to generate private subnets with cidrsubnet(). Set to a value that avoids existing subnet CIDRs in your account."
}