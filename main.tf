module "network" {
  source            = "./modules/network"
  availability_zone = "us-east-2a" //duda pablito, hay dos availabilities zone
  cidr_block        = "10.0.0.0/16"
  public_subnet     = "10.0.0.0/24"
  private_subnet    = "10.0.1.0/24"
}

module "ec2-linux-1" {
  source    = "./modules/ec2-linux"
  ec2name   = "EC2_1"
  key_name  = "keyName1"
  vpc_id    = module.network.vpc_id
  subnet_id = module.network.public_subnet
}

module "ec2-linux-2" {
  source   = "./modules/ec2-linux"
  ec2name  = "EC2_2"
  key_name = "keyName2"

  vpc_id    = module.network.vpc_id
  subnet_id = module.network.private_subnet
}

module "rds" {
  source                  = "./modules/rds"
  vpc_id                  = module.network.vpc_id
  private_subnet          = module.network.private_subnet
  db_name                 = "db-rds"
  secret_password_id      = "example/db/dev"
  engine                  = "postgres"
  engine_version          = "13.4"
  rds_instance_class      = "db.t3.micro"
  rds_storage             = "20"
  backup_retention_period = 7
  identifier              = "peinfra_RDS"
  cidr_block              = "172.25.0.0/16"
}
