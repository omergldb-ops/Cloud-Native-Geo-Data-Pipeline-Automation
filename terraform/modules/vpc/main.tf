resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
}
resource "aws_subnet" "private" {
  count             = 2
  vpc_id            = aws_vpc.this.id
  cidr_block        = "10.0.${count.index}.0/24"
  availability_zone = element(["us-east-1a", "us-east-1b"], count.index)
  tags = {
    Name = "private-subnet-${count.index}"
  }
}
resource "aws_internet_gateway" "igw" { vpc_id = aws_vpc.this.id }
