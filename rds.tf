#creating database subnet group
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "main"
  subnet_ids = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
}

#create our rds database using terraform
resource "aws_db_instance" "postgres" {
  identifier              = var.db_identifier
  db_name                 = var.rds_db_name
  username                = var.rds_username
  password                = var.db_password
  port                    = var.rds_port
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.rds_instance_class
  allocated_storage       = var.db_storage
  storage_encrypted       = var.storage_encrypted
  vpc_security_group_ids  = [aws_security_group.rds.id]
  db_subnet_group_name    = aws_db_subnet_group.db_subnet_group.name
  multi_az                = var.multi_az
  storage_type            = var.storage_type
  publicly_accessible     = var.public_access
  backup_retention_period = var.backup_retention_period
  skip_final_snapshot     = var.skip_final_snapshot

  tags = {
    Name = "e-learning_postgres-${terraform.workspace}"
  }
}

    
 