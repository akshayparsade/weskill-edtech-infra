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

# Get default VPC
data "aws_vpc" "default" {
  default = true
}

# Get default subnets, but only in supported AZs
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }

  filter {
    name   = "availability-zone"
    values = ["us-east-1a", "us-east-1b", "us-east-1c"]
  }
}


# fetch secret by name (we'll make this name configurable)
# data "aws_secretsmanager_secret_version" "rds_password" {
#   secret_id = var.rds_secret_name
# }

module "rds" {
  source                = "./modules/rds"
  project               = var.eks_project
  instance_class        = var.rds_instance_class
  allocated_storage     = var.rds_allocated_storage
  max_allocated_storage = var.rds_max_allocated_storage
  username              = var.rds_username
  password              = var.rds_password   # <- pass fixed value
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
    vpc_id     = data.aws_vpc.default.id
    subnet_ids = data.aws_subnets.default.ids
}

module "s3" {
  source = "./modules/s3"
  s3_bucket_name = var.s3_bucket_name
  environment = var.s3_environment
}
