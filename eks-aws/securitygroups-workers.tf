# workers
resource "aws_security_group" "node-wrkgrp" {
  name        = "terraform-eks-worker-node"
  description = "Security group for all nodes in the cluster"
  vpc_id      = module.vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name"                                      = "terraform-eks-dev-node"
    "kubernetes.io/cluster/${var.cluster-name}" = "owned"
  }
}

resource "aws_security_group_rule" "node-ingress-self" {
  description              = "Allow node to communicate with each other"
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.node-wrkgrp.id
  source_security_group_id = aws_security_group.node-wrkgrp.id
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "node-ingress-cluster" {
  description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  from_port                = 1025
  protocol                 = "tcp"
  security_group_id        = aws_security_group.node-wrkgrp.id
  source_security_group_id = aws_security_group.cluster-group.id
  to_port                  = 65535
  type                     = "ingress"
}

// We can Create SG creation with for_each Conditions too

// variable "sg_ports" {
//   type        = list(number)
//   description = "list of ingress ports"
//   default     = [8200, 8201,8300, 9200, 9500]
// }

// resource "aws_security_group" "dynamicsg" {
//   name        = "dynamic-sg"
//   description = "Ingress for Vault"

//   dynamic "ingress" {
//     for_each = var.sg_ports
//     iterator = port
//     content {
//       from_port   = port.value
//       to_port     = port.value
//       protocol    = "tcp"
//       cidr_blocks = ["0.0.0.0/0"]
//     }
//   }

//   dynamic "egress" {
//     for_each = var.sg_ports
//     content {
//       from_port   = egress.value
//       to_port     = egress.value
//       protocol    = "tcp"
//       cidr_blocks = ["0.0.0.0/0"]
//     }
//   }
// }
