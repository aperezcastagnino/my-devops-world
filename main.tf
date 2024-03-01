module "network" {
  source            = "./modules/network"
  availability_zone = "us-east-2a" //duda pablito, hay dos availabilities zone
  cidr_block        = "10.0.0.0/16"
  public_subnet     = "10.0.0.0/24"
  private_subnet    = "10.0.1.0/24"
}

module "ec2-linux-1" {
  source  = "./modules/ec2-linux"
  ec2name = "EC2_1"

  vpc_id    = module.network.vpc_id
  subnet_id = module.network.public_subnet
}

# module "ec2-linux-2" {
#   source  = "./modules/ec2-linux"
#   ec2name = "EC2_2"

#   vpc_id    = module.network.vpc_id
#   subnet_id = module.network.private_subnet
# }

# module "rds" {
#   source = "./modules/rds"
#   region = var.region
#   rds_data = {
#     name              = "db-rds",
#     engine            = "postgres",
#     engine_version    = "13.4",
#     instance_class    = "db.t3.micro",
#     allocated_storage = 5,
#     family            = "postgres13"
#   }
#   db-name                = "db"
#   secret_password_id     = "example/db/dev"
#   vpc_security_group_ids = [module.module-network.security_group_id]
#   subnet_ids             = [module.module-network.network_interface_1_id]
#   subnet_group           = "subnet_group"
# }
