resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
}

resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidrs) > 0 ? length(var.private_subnet_cidrs) : var.private_subnet_count

  vpc_id = aws_vpc.this.id

  cidr_block = length(var.private_subnet_cidrs) > 0 ? var.private_subnet_cidrs[count.index] : cidrsubnet(aws_vpc.this.cidr_block, 8, var.private_subnet_start_index + count.index)

  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name = "private-subnet-${count.index}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this.id
}
