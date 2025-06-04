module "vpc" {

  source  = "terraform-aws-modules/vpc/aws"
  version = "2.6.0"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = slice(data.aws_availability_zones.available.names, 0, 3)
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = false
  enable_vpn_gateway = false
  tags = {
    "Name"                                      = "terraform-eks-dev-vpc"
    "kubernetes.io/cluster/${var.cluster-name}" = "shared"
  }
}

// if we want to create VPC without module we can follow below code

// resource "aws_vpc" "demo" {
//   cidr_block = "10.0.0.0/16"

//   tags = map(
//     "Name", "terraform-eks-demo-node",
//     "kubernetes.io/cluster/${var.cluster-name}", "shared",
//   )
// }

// resource "aws_subnet" "sn" {
//   count = 2

//   availability_zone       = data.aws_availability_zones.available.names[count.index]
//   cidr_block              = "10.0.${count.index}.0/24"
//   map_public_ip_on_launch = true
//   vpc_id                  = aws_vpc.demo.id

//   tags = map(
//     "Name", "terraform-eks-demo-node",
//     "kubernetes.io/cluster/${var.cluster-name}", "shared",
//   )
// }

// resource "aws_internet_gateway" "demo" {
//   vpc_id = aws_vpc.demo.id

//   tags = {
//     Name = "terraform-eks-demo"
//   }
// }

// resource "aws_route_table" "route" {
//   vpc_id = aws_vpc.demo.id

//   route {
//     cidr_block = "0.0.0.0/0"
//     gateway_id = aws_internet_gateway.demo.id
//   }
// }

// resource "aws_route_table_association" "demo" {
//   count = 2

//   subnet_id      = aws_subnet.demo.*.id[count.index]
//   route_table_id = aws_route_table.demo.id
// }