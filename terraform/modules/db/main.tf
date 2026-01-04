resource "aws_db_subnet_group" "this" {
  name = "asterra-db-subnet"
  subnet_ids = var.subnet_ids
}
resource "aws_security_group" "db" {
  vpc_id = var.vpc_id
  ingress {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    cidr_blocks = ["10.0.0.0/16"] 
  }
}
resource "aws_db_instance" "this" {
  identifier = "asterra-db"
  engine = "postgres"
  engine_version = "15"
  instance_class = "db.t3.micro"
  db_name = "asterradb"
  username = "dbadmin"
  password = var.db_password
  db_subnet_group_name = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.db.id]
  allocated_storage = 20
  skip_final_snapshot = true
}
