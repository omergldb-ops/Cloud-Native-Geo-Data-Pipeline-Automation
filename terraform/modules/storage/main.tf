resource "aws_ecr_repository" "app_repo" {
  name                 = "asterra-app"
  force_delete         = true # מאפשר ל-Destroy למחוק גם אם יש אימג'ים
}

resource "aws_s3_bucket" "data_bucket" {
  bucket        = "asterra-data-ingestion-${random_id.suffix.hex}"
  force_destroy = true # מוחק את הבאקט גם אם הוא לא ריק בדיסטרוי
}

resource "random_id" "suffix" { byte_length = 4 }