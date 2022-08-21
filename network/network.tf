#VPC resource
resource "aws_vpc" "main" {
  cidr_block = var.vpc.Network_CIDR

  tags = {
    Name     = var.vpc.name
  }
}
# Internet gateway
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.IGW_name
  }
}

#Subnets
resource "aws_subnet" "subnets" {
    count = length(var.subnets_cidr_block)
    vpc_id     = aws_vpc.main.id
    cidr_block = var.subnets_cidr_block[count.index]
    availability_zone = var.subnet_az[count.index]
    tags = {
        Name = var.subnets_names[count.index]
    }
}

# Nat gateway
resource "aws_eip" "NatEip" {
  vpc      = true
}

resource "aws_nat_gateway" "NatGw" {
  allocation_id = aws_eip.NatEip.id
  subnet_id     = aws_subnet.subnets[0].id

  tags = {
    Name = "NatGw"
  }
  depends_on = [
    aws_internet_gateway.IGW,
    aws_subnet.subnets
  ]
}

# Route table
resource "aws_route_table" "route_tables" {
    count = length(var.rt_names)
    vpc_id = aws_vpc.main.id
    tags = {
        Name = var.rt_names[count.index]
    }
}

# Route tabel association
resource "aws_route_table_association" "RT_associate" {
  count = length(var.subnet_name_association)
  subnet_id      = aws_subnet.subnets[count.index].id
  route_table_id = data.aws_route_table.route_table_name[count.index].id

  depends_on = [
    aws_route_table.route_tables
  ]
}

# Routes for ALB subnets
resource "aws_route" "ALBRoute" {
  route_table_id = aws_route_table.route_tables[0].id
  gateway_id = aws_internet_gateway.IGW.id
  destination_cidr_block = "0.0.0.0/0"
  depends_on = [
    aws_internet_gateway.IGW,
    aws_route_table.route_tables
  ]
}

# Route for Frontend subnets
resource "aws_route" "FrontendRoute" {
  route_table_id = aws_route_table.route_tables[1].id
  gateway_id = aws_nat_gateway.NatGw.id
  destination_cidr_block = "0.0.0.0/0"
  depends_on = [
    aws_internet_gateway.IGW,
    aws_route_table.route_tables
  ]
}

# Network ACL
resource "aws_network_acl" "network_acl" {
    count = length(var.network_acl_name)
    vpc_id = aws_vpc.main.id

    tags = {
        Name = var.network_acl_name[count.index]
    }
}

# Network ACL association
#Public ACL association
resource "aws_network_acl_association" "ALB1" {
  network_acl_id = aws_network_acl.network_acl[0].id
  subnet_id = aws_subnet.subnets[0].id
}

resource "aws_network_acl_association" "ALB2" {
  network_acl_id = aws_network_acl.network_acl[0].id
  subnet_id = aws_subnet.subnets[1].id
}

resource "aws_network_acl_association" "ALB3" {
  network_acl_id = aws_network_acl.network_acl[0].id
  subnet_id = aws_subnet.subnets[2].id
}

#Private ACL association
resource "aws_network_acl_association" "Frontend1" {
  network_acl_id = aws_network_acl.network_acl[1].id
  subnet_id = aws_subnet.subnets[3].id
}

resource "aws_network_acl_association" "Frontend2" {
  network_acl_id = aws_network_acl.network_acl[1].id
  subnet_id = aws_subnet.subnets[4].id
}

resource "aws_network_acl_association" "Frontend3" {
  network_acl_id = aws_network_acl.network_acl[1].id
  subnet_id = aws_subnet.subnets[5].id
}

resource "aws_network_acl_association" "DB1" {
  network_acl_id = aws_network_acl.network_acl[1].id
  subnet_id = aws_subnet.subnets[6].id
}

resource "aws_network_acl_association" "DB2" {
  network_acl_id = aws_network_acl.network_acl[1].id
  subnet_id = aws_subnet.subnets[7].id
}

resource "aws_network_acl_association" "DB3" {
  network_acl_id = aws_network_acl.network_acl[1].id
  subnet_id = aws_subnet.subnets[8].id
}

#Public ACL's rules
resource "aws_network_acl_rule" "PublicACL_rules" {
  count = length(var.PublicACL_cidr_block)
  network_acl_id = aws_network_acl.network_acl[0].id
  rule_number    = var.PublicACL_rule_number[count.index]
  egress         = var.PublicACL_egress[count.index]
  protocol       = var.PublicACL_protocol[count.index]
  rule_action    = var.PublicACL_rule_action[count.index]
  cidr_block     = var.PublicACL_cidr_block[count.index]
  from_port      = var.PublicACL_from_port[count.index]
  to_port        = var.PublicACL_to_port[count.index]
}

#Private ACL's rules
resource "aws_network_acl_rule" "PrivateACL_rules" {
  count = length(var.PrivateACL_cidr_block)
  network_acl_id = aws_network_acl.network_acl[1].id
  rule_number    = var.PrivateACL_rule_number[count.index]
  egress         = var.PrivateACL_egress[count.index]
  protocol       = var.PrivateACL_protocol[count.index]
  rule_action    = var.PrivateACL_rule_action[count.index]
  cidr_block     = var.PrivateACL_cidr_block[count.index]
  from_port      = var.PrivateACL_from_port[count.index]
  to_port        = var.PrivateACL_to_port[count.index]
}

#Security groups
resource "aws_security_group" "SecurityGroups" {
  count = length(var.sg_names)
  vpc_id = aws_vpc.main.id
  name = var.sg_names[count.index]
  description = "Security group for the instaces"
  tags = {
    Name = var.sg_names[count.index]
  }

  depends_on = [
    aws_vpc.main
  ]
}

#ALBSG security group rules
#Ingress Rules
resource "aws_security_group_rule" "ALBSGIngress" {
  count             = length(var.ALBSGIngress_cidr_blocks)
  type              = "ingress"
  from_port         = var.ALBSGIngress_from_port[count.index]
  to_port           = var.ALBSGIngress_to_port[count.index]
  protocol          = var.ALBSGIngress_protocol[count.index]
  cidr_blocks       = [var.ALBSGIngress_cidr_blocks[count.index]]
  security_group_id = aws_security_group.SecurityGroups[0].id
  depends_on = [
    aws_security_group.SecurityGroups
  ]
}

#Egress
resource "aws_security_group_rule" "ALBSGEgress" {
  count             = length(var.ALBSGEgress_cidr_blocks)
  type              = "egress"
  from_port         = var.ALBSGEgress_from_port[count.index]
  to_port           = var.ALBSGEgress_to_port[count.index]
  protocol          = var.ALBSGEgress_protocol[count.index]
  cidr_blocks       = [var.ALBSGEgress_cidr_blocks[count.index]]
  security_group_id = aws_security_group.SecurityGroups[0].id
  depends_on = [
    aws_security_group.SecurityGroups
  ]  
}

#FrontendSG security group rules
#Ingress Rules
resource "aws_security_group_rule" "FrontendSGIngress" {
  count             = length(var.FrontendSGIngress_cidr_blocks)
  type              = "ingress"
  from_port         = var.FrontendSGIngress_from_port[count.index]
  to_port           = var.FrontendSGIngress_to_port[count.index]
  protocol          = var.FrontendSGIngress_protocol[count.index]
  cidr_blocks       = [var.FrontendSGIngress_cidr_blocks[count.index]]
  security_group_id = aws_security_group.SecurityGroups[1].id
  depends_on = [
    aws_security_group.SecurityGroups
  ]  
}

#Egress
resource "aws_security_group_rule" "FrontendSGEgress" {
  count             = length(var.FrontendSGEgress_cidr_blocks)
  type              = "egress"
  from_port         = var.FrontendSGEgress_from_port[count.index]
  to_port           = var.FrontendSGEgress_to_port[count.index]
  protocol          = var.FrontendSGEgress_protocol[count.index]
  cidr_blocks       = [var.FrontendSGEgress_cidr_blocks[count.index]]
  security_group_id = aws_security_group.SecurityGroups[1].id
  depends_on = [
    aws_security_group.SecurityGroups
  ]  
}

#DBSG security group rules
#Ingress Rules
resource "aws_security_group_rule" "DBSGIngress" {
  count             = length(var.DBSGIngress_cidr_blocks)
  type              = "ingress"
  from_port         = var.DBSGIngress_from_port[count.index]
  to_port           = var.DBSGIngress_to_port[count.index]
  protocol          = var.DBSGIngress_protocol[count.index]
  cidr_blocks       = [var.DBSGIngress_cidr_blocks[count.index]]
  security_group_id = aws_security_group.SecurityGroups[2].id
  depends_on = [
    aws_security_group.SecurityGroups
  ]  
}

#Egress
resource "aws_security_group_rule" "DBSGEgress" {
  count             = length(var.DBSGEgress_cidr_blocks)
  type              = "egress"
  from_port         = var.DBSGEgress_from_port[count.index]
  to_port           = var.DBSGEgress_to_port[count.index]
  protocol          = var.DBSGEgress_protocol[count.index]
  cidr_blocks       = [var.DBSGEgress_cidr_blocks[count.index]]
  security_group_id = aws_security_group.SecurityGroups[2].id
  depends_on = [
    aws_security_group.SecurityGroups
  ]  
}
