output "vpc_id" {
  value = aws_vpc.this.id
}

output "private_subnets" {
  value = [
    aws_subnet.private_1.id, 
    aws_subnet.private_2.id
  ]
  description = "List of IDs of private subnets"
}