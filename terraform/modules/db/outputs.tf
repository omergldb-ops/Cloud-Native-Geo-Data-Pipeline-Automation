# כתובת ה-Endpoint לחיבור האפליקציה לבסיס הנתונים
output "db_instance_endpoint" {
  description = "The connection endpoint for the RDS instance"
  value       = aws_db_instance.this.endpoint
}

# שם בסיס הנתונים (שימושי להזרקה כמשתנה סביבה ב-Helm)
output "db_name" {
  description = "The name of the database"
  value       = aws_db_instance.this.db_name
}

# ה-ID של ה-Security Group (שימושי אם תרצה להוסיף חוקים במודולים אחרים)
output "db_security_group_id" {
  description = "The ID of the security group for the database"
  value       = aws_security_group.db.id
}

# ה-ARN של ה-DB (לצרכי IAM או ניטור)
output "db_instance_arn" {
  description = "The ARN of the RDS instance"
  value       = aws_db_instance.this.arn
}