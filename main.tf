module "network" {
    source = ".\\network\\"
    providers = {
        aws = aws.us
    }

    #VPC Inputs
    vpc = {
        name = var.vpc.name
        Network_CIDR = var.vpc.Network_CIDR
    }

    # Internet Gateway Inputs
    IGW_name = var.IGW_name

    # Internet Gateway Inputs
    NatGw_name = var.NatGw_name

    #Subnet Inputs
    subnets_names      = var.subnets_names
    subnets_cidr_block = var.subnets_cidr_block
    subnet_az          = var.subnet_az

    #Route table inputs
    rt_names = var.rt_names

    #Route table inputs association
    subnet_name_association = var.subnet_name_association
    route_table_name_association = var.route_table_name_association

    #Network ACL inputs
    network_acl_name = var.network_acl_name
    
    #Public ACL's rules inputs
    PublicACL_rule_number = var.PublicACL_rule_number
    PublicACL_egress = var.PublicACL_egress
    PublicACL_protocol = var.PublicACL_protocol
    PublicACL_rule_action = var.PublicACL_rule_action
    PublicACL_cidr_block = var.PublicACL_cidr_block
    PublicACL_from_port = var.PublicACL_from_port
    PublicACL_to_port = var.PublicACL_to_port

    #Private ACL's rules inputs
    PrivateACL_rule_number = var.PrivateACL_rule_number
    PrivateACL_egress = var.PrivateACL_egress
    PrivateACL_protocol = var.PrivateACL_protocol
    PrivateACL_rule_action = var.PrivateACL_rule_action
    PrivateACL_cidr_block = var.PrivateACL_cidr_block
    PrivateACL_from_port = var.PrivateACL_from_port
    PrivateACL_to_port = var.PrivateACL_to_port

    #Security groups inputs
    sg_names = var.sg_names

    #Security groups rules inputs
    #ALBSG rules inputs
    #ALBSG Ingress inputs
    ALBSGIngress_from_port = var.ALBSGIngress_from_port
    ALBSGIngress_to_port = var.ALBSGIngress_to_port
    ALBSGIngress_protocol = var.ALBSGIngress_protocol
    ALBSGIngress_cidr_blocks = var.ALBSGIngress_cidr_blocks

    #ALBSG Egress inputs
    ALBSGEgress_from_port = var.ALBSGEgress_from_port
    ALBSGEgress_to_port = var.ALBSGEgress_to_port
    ALBSGEgress_protocol = var.ALBSGEgress_protocol
    ALBSGEgress_cidr_blocks = var.ALBSGEgress_cidr_blocks

    #FrontendSG rules inputs
    #FrontendSG Ingress
    FrontendSGIngress_from_port = var.FrontendSGIngress_from_port
    FrontendSGIngress_to_port = var.FrontendSGIngress_to_port
    FrontendSGIngress_protocol = var.FrontendSGIngress_protocol
    FrontendSGIngress_cidr_blocks = var.FrontendSGIngress_cidr_blocks

    #FrontendSG Egress
    FrontendSGEgress_from_port = var.FrontendSGEgress_from_port
    FrontendSGEgress_to_port = var.FrontendSGEgress_to_port
    FrontendSGEgress_protocol = var.FrontendSGEgress_protocol
    FrontendSGEgress_cidr_blocks = var.FrontendSGEgress_cidr_blocks

    #DBSG rules inputs
    #DBSG Ingress
    DBSGIngress_from_port = var.DBSGIngress_from_port
    DBSGIngress_to_port = var.DBSGIngress_to_port
    DBSGIngress_protocol = var.DBSGIngress_protocol
    DBSGIngress_cidr_blocks = var.DBSGIngress_cidr_blocks

    #DBSG Egress
    DBSGEgress_from_port = var.DBSGEgress_from_port
    DBSGEgress_to_port = var.DBSGEgress_to_port
    DBSGEgress_protocol = var.DBSGEgress_protocol
    DBSGEgress_cidr_blocks = var.DBSGEgress_cidr_blocks
}