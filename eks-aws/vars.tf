variable "cluster-name" {
  default = "terraform-eks"
  type    = string
}


variable "vpc_name" {
  description = "Name of the VPC"
  default     = "eks-vpc"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

################################################
# Optional variables
################################################
variable "public_subnets" {
  description = "List of CIDRs for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnets" {
  description = "List of CIDRs for private subnets"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "instance_type" {
  type = "map"

  default = {
    default = "t2.medium"
    dev     = "t2.medium"
    qa      = "t2.large"
    prod    = "t2.xlarge"
  }
}


variable "dynamodb_table_name" {
  description = "Name of the VPC"
  default     = "eks-synamo-table"
  type        = string
}
