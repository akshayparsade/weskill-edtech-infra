environment = "dev"
aws_region = "us-east-1"

# RDS Variables
rds_instance_class        = "db.t3.micro"
rds_allocated_storage     = 20
rds_max_allocated_storage = 100
rds_username              = "admin"

# tell Terraform which Secrets Manager secret to use
rds_secret_name = "rds/dev/password"

# EKS Variables
eks_project            = "weskill"
eks_desired_nodes      = 2
eks_max_nodes          = 2
eks_min_nodes          = 2
eks_node_instance_type = "t3.medium"

# S3 Variables
s3_bucket_name = "weskill-frontend-dev-buxx"
s3_environment = "dev" 