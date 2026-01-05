# תיקון ה-ECR: גישה למשאב הנכון ששלחת קודם
output "ecr_url" {
  value = aws_ecr_repository.app_repo.repository_url
}

# תיקון ה-EKS: גישה דרך המודול (module.eks)
output "oidc_provider_arn" {
  value = module.eks.oidc_provider_arn
}

output "oidc_provider" {
  value = module.eks.oidc_provider
}

# ה-Role של האפליקציה מהמודול של ה-IAM
output "app_role_arn" {
  value = module.iam.app_role_arn
}

# (אופציונלי) כתובת ה-RDS וה-S3 כדי שה-Workflow יוכל למשוך אותם
output "rds_endpoint" {
  value = module.db.db_instance_endpoint 
}

output "s3_bucket" {
  value = module.s3.bucket_name
}