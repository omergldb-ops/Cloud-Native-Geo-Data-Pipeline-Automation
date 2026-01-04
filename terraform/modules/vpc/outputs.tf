output "private_subnets" {
  value = [aws_subnet.private_1.id, aws_subnet.private_2.id]
}