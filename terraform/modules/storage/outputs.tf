output "ecr_repository_url" {
  value = aws_ecr_repository.app_repo.repository_url
}

output "s3_bucket_name" {
  value = aws_s3_bucket.app_data.id
}