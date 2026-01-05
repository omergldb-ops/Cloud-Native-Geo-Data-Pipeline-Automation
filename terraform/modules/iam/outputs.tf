output "app_role_arn" {
  value       = aws_iam_role.app_role.arn
  description = "The ARN of the IAM role for the application"
}