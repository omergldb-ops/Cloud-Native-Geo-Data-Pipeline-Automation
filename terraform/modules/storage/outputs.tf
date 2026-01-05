# כתובת ה-URL של ה-ECR (נחוץ ל-Docker Push ב-GitHub Actions)
output "ecr_repository_url" {
  description = "The URL of the ECR repository"
  value       = aws_ecr_repository.app_repo.repository_url
}

# השם הסופי של ה-S3 Bucket (כולל הסיומת האקראית)
output "s3_bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.data_bucket.id
}

# ה-ARN של ה-S3 Bucket (שימושי להגדרות IAM פנימיות)
output "s3_bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.data_bucket.arn
}