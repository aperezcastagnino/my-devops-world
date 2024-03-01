resource "aws_security_group" "rds_sg" {
  name   = "${locals.prefix}_RDS_security_group"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "myinstance" {
  engine                  = var.engine
  identifier              = var.identifier
  allocated_storage       = var.rds_storage
  engine_version          = var.engine_version
  instance_class          = var.rds_instance_class
  db_name                 = var.db_name
  username                = jsondecode(data.aws_secretsmanager_secret_version.secret_password_rds.secret_string)["username"]
  password                = jsondecode(data.aws_secretsmanager_secret_version.secret_password_rds.secret_string)["password"]
  vpc_security_group_ids  = ["${aws_security_group.rds_sg.id}"]
  skip_final_snapshot     = true
  publicly_accessible     = var.rds_public
  db_subnet_group_name    = aws_db_subnet_group.subnetgroup.name
  backup_retention_period = var.backup_retention_period
  storage_type            = "gp3"
}

resource "aws_db_subnet_group" "subnetgroup" {
  name       = "${locals.prefix}__subnet_group"
  subnet_ids = var.private_subnets

  tags = {
    Name        = "${locals.prefix}_subnet_group"
  }
}

locals {
  prefix = "peinfra"
}
