output "app_role_arn" {
  value = module.iam.app_role_arn
}

output "ecr_url" {
  value = module.ecr.repository_url # וודא שזה השם אצלך
}

output "rds_endpoint" {
  value = module.db.db_instance_endpoint # וודא שזה השם אצלך
}

output "s3_bucket" {
  value = module.s3.bucket_name # וודא שזה השם אצלך
}