#Network module vars
#VPC vars
variable "vpc" {
    type = map(any)
        default = {
            name  = ""
            Network_CIDR = ""
        }
}

# Internet Gateway vars
variable "IGW_name" {
    type = string
}

# Nat Gateway vars
variable "NatGw_name" {
    type = string
}

#Subnet vars
variable "subnets_names" {
  type = list(string)
  description = "Name of the subnets"
}

variable "subnets_cidr_block" {
    type = list(string)
    description = "List of cidr blocks of public subnets"
}

variable "subnet_az" {
    type = list(string)
    description = "List of cidr blocks of public subnets"
}

#Route table vars
variable "rt_names" {
    type = list(string)
    description = "Name of the Route Tables"
}

#Route table association vars
variable "subnet_name_association" {
  type = list(string)
  description = "Names of the subnets to associate with a route table"
}

variable "route_table_name_association" {
  type = list(string)
  description = "name of the route tables to association with the subnets"
}

#Network ACL vars
variable "network_acl_name" {
    type = list(string)
}

#Public ACL's rules vars
variable "PublicACL_rule_number" {
    type = list(number)
    description = "Number of the ACL rule"
}
variable "PublicACL_egress" {
    type = list(string)
    description = "Egress option for the ACL rule (true for egress rule or false to ingress rule)"
}
variable "PublicACL_protocol" {
    type = list(string)
    description = "Protocol for the ACL rule"
}
variable "PublicACL_rule_action" {
    type = list(string)
    description = "Rule action (allow or deny) for the ACL rule"
}
variable "PublicACL_cidr_block" {
    type = list(string)
    description = "cidr block for the rule for the ACL rule"
}
variable "PublicACL_from_port" {
    type = list(string)
    description = "First port for the rule for the ACL rule"
}
variable "PublicACL_to_port" {
    type = list(string)
    description = "Last port for the rule for the ACL rule"
}

#Private ACL's rules vars
variable "PrivateACL_rule_number" {
    type = list(number)
    description = "Number of the ACL rule"
}
variable "PrivateACL_egress" {
    type = list(string)
    description = "Egress option for the ACL rule (true for egress rule or false to ingress rule)"
}
variable "PrivateACL_protocol" {
    type = list(string)
    description = "Protocol for the ACL rule"
}
variable "PrivateACL_rule_action" {
    type = list(string)
    description = "Rule action (allow or deny) for the ACL rule"
}
variable "PrivateACL_cidr_block" {
    type = list(string)
    description = "cidr block for the rule for the ACL rule"
}
variable "PrivateACL_from_port" {
    type = list(string)
    description = "First port for the rule for the ACL rule"
}
variable "PrivateACL_to_port" {
    type = list(string)
    description = "Last port for the rule for the ACL rule"
}

#Security groups vars
variable "sg_names" {
    type = list(string)
    description = "Name of the security groups"
}

#Security groups rules vars
#ALBSG rules vars
#ALBSG Ingress vars
variable "ALBSGIngress_from_port" {
    type = list(string)
    description = "from_port for ALBSG security groups ingress rules"
}

variable "ALBSGIngress_to_port" {
    type = list(string)
    description = "to_port for ALBSG security groups ingress rules"
}

variable "ALBSGIngress_protocol" {
    type = list(string)
    description = "protocol for ALBSG security groups ingress rules"
}

variable "ALBSGIngress_cidr_blocks" {
    type = list(string)
    description = "cidr_blocks for ALBSG security groups ingress rules"
}

#ALBSG Egress vars
variable "ALBSGEgress_from_port" {
    type = list(string)
    description = "from_port for ALBSG security groups ingress rules"
}

variable "ALBSGEgress_to_port" {
    type = list(string)
    description = "to_port for ALBSG security groups ingress rules"
}

variable "ALBSGEgress_protocol" {
    type = list(string)
    description = "protocol for ALBSG security groups ingress rules"
}

variable "ALBSGEgress_cidr_blocks" {
    type = list(string)
    description = "cidr_blocks for ALBSG security groups ingress rules"
}

#FrontendSG SG rules vars
#FrontendSG Ingress vars
variable "FrontendSGIngress_from_port" {
    type = list(string)
    description = "from_port for bastion security groups ingress rules"
}

variable "FrontendSGIngress_to_port" {
    type = list(string)
    description = "to_port for bastion security groups ingress rules"
}

variable "FrontendSGIngress_protocol" {
    type = list(string)
    description = "protocol for bastion security groups ingress rules"
}

variable "FrontendSGIngress_cidr_blocks" {
    type = list(string)
    description = "cidr_blocks for bastion security groups ingress rules"
}

#FrontendSG Egress vars
variable "FrontendSGEgress_from_port" {
    type = list(string)
    description = "from_port for bastion security groups ingress rules"
}

variable "FrontendSGEgress_to_port" {
    type = list(string)
    description = "to_port for bastion security groups ingress rules"
}

variable "FrontendSGEgress_protocol" {
    type = list(string)
    description = "protocol for bastion security groups ingress rules"
}

variable "FrontendSGEgress_cidr_blocks" {
    type = list(string)
    description = "cidr_blocks for bastion security groups ingress rules"
}

#DBSG SG rules vars
#DBSG Ingress vars
variable "DBSGIngress_from_port" {
    type = list(string)
    description = "from_port for bastion security groups ingress rules"
}

variable "DBSGIngress_to_port" {
    type = list(string)
    description = "to_port for bastion security groups ingress rules"
}

variable "DBSGIngress_protocol" {
    type = list(string)
    description = "protocol for bastion security groups ingress rules"
}

variable "DBSGIngress_cidr_blocks" {
    type = list(string)
    description = "cidr_blocks for bastion security groups ingress rules"
}

#DBSG Egress vars
variable "DBSGEgress_from_port" {
    type = list(string)
    description = "from_port for bastion security groups ingress rules"
}

variable "DBSGEgress_to_port" {
    type = list(string)
    description = "to_port for bastion security groups ingress rules"
}

variable "DBSGEgress_protocol" {
    type = list(string)
    description = "protocol for bastion security groups ingress rules"
}

variable "DBSGEgress_cidr_blocks" {
    type = list(string)
    description = "cidr_blocks for bastion security groups ingress rules"
}