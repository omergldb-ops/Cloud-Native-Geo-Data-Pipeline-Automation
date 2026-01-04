output "ecr_url" {
  value = module.storage.ecr_url
}

output "s3_bucket" {
  value = module.storage.s3_bucket_name
}

output "rds_endpoint" {
  value = module.db.db_endpoint
}

output "app_iam_role_arn" {
  value = module.iam.role_arn
}