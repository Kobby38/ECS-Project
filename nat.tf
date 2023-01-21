# elastic ip
resource "aws_eip" "elastic-ip" {
  vpc = true
  associate_with_private_ip = var.elastic-ip-for-nat-gateway
  #Meta Arguement
  depends_on = [aws_internet_gateway.igw]
}

# nat gateway 
resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.elastic-ip.id
  subnet_id     = aws_subnet.public_subnet-1.id
  depends_on    = [aws_eip.elastic-ip]
  tags = {
    Name = "nat_gateway-${terraform.workspace}"
  }
}


 # Route NAT Gateway with private Route table
resource "aws_route" "production-nat-association" {
  route_table_id         = aws_route_table.private-route-table1.id
  nat_gateway_id         = aws_nat_gateway.ngw.id
  destination_cidr_block = var.nat-gateway-destination-cidr-block
}

# Nat Gateway for internet through the public subnet

resource "aws_eip" "EIP_for_NG" {
  vpc                       = true
  associate_with_private_ip = var.elastic-ip-for-nat-gateway
  }

  resource "aws_nat_gateway" "Prod-Nat-gateway" {
  allocation_id = aws_eip.EIP_for_NG.id
  subnet_id     = aws_subnet.public_subnet-1.id
 }

