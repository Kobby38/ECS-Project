# create public subnets 
#eu-west 2a
resource "aws_subnet" "public_subnet-1" {
  vpc_id                  = aws_vpc.ecs_vpc.id
  cidr_block              = var.public_subnet-1_cidr_block 
  availability_zone       = var.public_subnet-1_availability_zonea
  map_public_ip_on_launch = var.public_subnet-1_map_public_ip_on_launch
  tags = {
    Name = "public_subnet_1-${terraform.workspace}"
  }
}
#eu-west 2b
resource "aws_subnet" "public_subnet-2" {
  vpc_id                  = aws_vpc.ecs_vpc.id
  cidr_block              = var.public_subnet-2_cidr_block
  availability_zone       = var.public_subnet-2_availability_zoneb
  map_public_ip_on_launch = var.public_subnet-2_map_public_ip_on_launch
  tags = {
    Name = "public_subnet_2-${terraform.workspace}"
  }
}
#create private subnets
#eu-west 2a
resource "aws_subnet" "private_subnet_1" {
  vpc_id                  = aws_vpc.ecs_vpc.id
  cidr_block              = var.private_subnet-1_cidr_block
  availability_zone       = var.private_subnet-1_availability_zonea
  tags = {
    Name = "private_subnet_1-${terraform.workspace}"
  }
}
#eu-west 2b
resource "aws_subnet" "private_subnet_2" {
  vpc_id                  = aws_vpc.ecs_vpc.id
  cidr_block              = var.private_subnet-2_cidr_block
  availability_zone       = var.private_subnet-2_availability_zoneb
  tags = {
    Name = "private_subnet_2-${terraform.workspace}"
  }
}

