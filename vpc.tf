// create VPC
resource "aws_vpc" "ecs_vpc" {
  cidr_block           = var.vpc_cidr_block
  instance_tenancy     = var.vpc_instance_tenancy
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = {
    Name = "e-learning-vpc-${terraform.workspace}"
  }
}