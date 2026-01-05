output "ecr_url" {
  value = module.storage.ecr_repository_url
}

output "s3_bucket" {
  value = module.storage.s3_bucket_name
}

output "rds_endpoint" {
  value = module.db.db_instance_endpoint
}

output "cluster_name" {
  value = module.eks.cluster_name
}

output "app_role_arn" {
  value = module.iam.app_role_arn
}

output "oidc_provider_arn" {
  value = module.eks.oidc_provider_arn
}

output "oidc_provider" {
  value = module.eks.oidc_provider
}