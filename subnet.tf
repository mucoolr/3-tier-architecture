variable "public_subnets" {
  type = map
}
variable "private_subnets" {
  type = map
}
variable "data_subnets" {
  type = map
}
resource "aws_subnet" "public-subnet" {
  vpc_id     = aws_vpc.VPC.id
  for_each = var.public_subnets
  availability_zone = "${var.region}${each.value}"
  cidr_block = each.key
  tags = {
    Name = "public-subnet-${each.value}"
  }
}
resource "aws_subnet" "private-subnet" {
  vpc_id     = aws_vpc.VPC.id
  for_each = var.private_subnets
  availability_zone = "${var.region}${each.value}"
  cidr_block = each.key
  tags = {
    Name = "private-subnet-${each.value}"
  }
}
resource "aws_subnet" "data-subnet" {
  vpc_id     = aws_vpc.VPC.id
  for_each = var.data_subnets
  availability_zone = "${var.region}${each.value}"
  cidr_block = each.key
  tags = {
    Name = "data-subnet-${each.value}"
  }
}

resource "aws_route_table_association" "public" {
  for_each  = aws_subnet.public-subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_route.id
} 
resource "aws_route_table_association" "private" {
  for_each  = aws_subnet.private-subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private_route.id
} 
resource "aws_route_table_association" "data" {
  for_each  = aws_subnet.data-subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.data_route.id
} 



