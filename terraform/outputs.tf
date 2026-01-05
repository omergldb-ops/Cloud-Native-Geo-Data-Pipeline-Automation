output "app_role_arn" {
  value = module.iam.app_role_arn
}

output "ecr_url" {
  value = module.ecr.repository_url
}

output "rds_endpoint" {
  value = module.db.db_endpoint 
}

output "s3_bucket" {
  value = module.storage.s3_bucket_name 
}