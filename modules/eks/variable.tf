
variable project {}
variable desired_nodes {}
variable max_nodes {}
variable min_nodes {}
variable node_instance_type {}
variable "environment" {}
variable "vpc_id" {
  description = "VPC ID for EKS"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs for EKS cluster"
  type        = list(string)
}

