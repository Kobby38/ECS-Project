# create public route table
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.ecs_vpc.id
}

#create Private route table 
resource "aws_route_table" "private-route-table1" {
  vpc_id = aws_vpc.ecs_vpc.id
 }

# Public route table association 
resource "aws_route_table_association" "public-route-table-association-1" {
  subnet_id      = aws_subnet.public_subnet-1.id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "public-route-table-association-2" {
  subnet_id      = aws_subnet.public_subnet-2.id
  route_table_id = aws_route_table.public-route-table.id
}

# Private route table association
resource "aws_route_table_association" "private-route-table1-association-1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private-route-table1.id
}

resource "aws_route_table_association" "private-route-table2-association-1" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private-route-table1.id
}