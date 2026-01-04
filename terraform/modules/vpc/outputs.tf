output "vpc_id" {
  value = aws_vpc.this.id
}
  output "private_subnets"
  {
  value = aws_subnet.private[*].id
  description = "List of IDs of private subnets"
  }