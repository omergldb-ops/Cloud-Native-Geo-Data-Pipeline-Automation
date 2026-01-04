### 1. ה-VPC הבסיסי
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "asterra-vpc"
  }
}

### 2. Internet Gateway - מאפשר יציאה לעולם
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "asterra-igw"
  }
}

### 3. סבנאטים ציבוריים (Public Subnets)
# חייבים לפחות אחד כדי שה-NAT Gateway יוכל לשבת בתוכו
resource "aws_subnet" "public" {
  count = 2 # מומלץ 2 עבור שרידות של ה-Load Balancers

  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(aws_vpc.this.cidr_block, 8, count.index + 100) # נתיב נפרד (100, 101...)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name                     = "public-subnet-${count.index}"
    "kubernetes.io/role/elb" = "1" # תג חשוב ל-EKS עבור Load Balancers חיצוניים
  }
}

### 4. NAT Gateway - מאפשר ל-EKS הפרטי לצאת לאינטרנט
resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id # ה-NAT יושב בסבנאט הציבורי הראשון

  depends_on = [aws_internet_gateway.igw]
}

### 5. סבנאטים פרטיים (כפי שהגדרת)
resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidrs) > 0 ? length(var.private_subnet_cidrs) : var.private_subnet_count

  vpc_id            = aws_vpc.this.id
  cidr_block        = length(var.private_subnet_cidrs) > 0 ? var.private_subnet_cidrs[count.index] : cidrsubnet(aws_vpc.this.cidr_block, 8, var.private_subnet_start_index + count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name                              = "private-subnet-${count.index}"
    "kubernetes.io/role/internal-elb" = "1" # תג חשוב ל-EKS עבור Load Balancers פנימיים
  }
}

### 6. טבלאות ניתוב (Route Tables)

# ניתוב עבור הסבנאטים הציבוריים (יוצאים דרך ה-IGW)
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public" {
  count          = 2
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# ניתוב עבור הסבנאטים הפרטיים (יוצאים דרך ה-NAT Gateway)
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
}

resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}