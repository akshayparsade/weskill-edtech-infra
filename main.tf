terraform {
  backend "s3" {
    bucket = "weskill-infra-backend-bux"
    region = "us-east-1"
    key = "terraform.tfstate"
    
  }
}

provider "aws" {
    region = var.aws_region
}


# fetch secret by name (we'll make this name configurable)
data "aws_secretsmanager_secret_version" "rds_password" {
  secret_id = var.rds_secret_name
}

module "rds" {
  source                = "./modules/rds"
  project               = var.eks_project
  instance_class        = var.rds_instance_class
  allocated_storage     = var.rds_allocated_storage
  max_allocated_storage = var.rds_max_allocated_storage
  username              = var.rds_username
  password              = data.aws_secretsmanager_secret_version.rds_password.secret_string
  environment           = var.environment
}

module "eks" {
    source = "./modules/eks"
    project = var.eks_project
    desired_nodes = var.eks_desired_nodes
    max_nodes  = var.eks_max_nodes
    min_nodes  = var.eks_min_nodes
    node_instance_type = var.eks_node_instance_type
    environment = var.environment
}

module "s3" {
  source = "./modules/s3"
  s3_bucket_name = var.s3_bucket_name
  environment = var.s3_environment
}
