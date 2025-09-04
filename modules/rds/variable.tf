variable "instance_class" {
  description = "RDS instance class (e.g. db.t3.micro)"
  type        = string
}

variable "allocated_storage" {
  description = "RDS allocated storage (GB)"
  type        = number
}

variable "max_allocated_storage" {
  description = "RDS max allocated storage (GB)"
  type        = number
}

variable "username" {
  description = "RDS master username"
  type        = string
}

variable "password" {
  description = "RDS master password"
  type        = string
  sensitive   = true
}

variable "project" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment (dev/stage/prod)"
  type        = string
}
