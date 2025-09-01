terraform {
  backend "s3" {
    bucket = "weskill-infra-backend-bux"
    region = "us-east-1"
    key = "terraform.tfstate"
    
  }
}

provider "aws" {
    region = "us-east-1"
}

module "rds" {
    source = "./modules/rds"
}

module "eks" {
    source = "./modules/eks"
    project = "weskill-edtech"
    desired_nodes = 2
    max_nodes  = 2
    min_nodes  = 2
    node_instance_type = "t2.medium"
    environment = "Dev"
}

module "s3" {
    source = "./modules/s3"
}