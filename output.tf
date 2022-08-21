#Network module outputs
#VPC outputs
output "vpc_output" {
  value = {
    vpc_name = module.network.vpc_output.vpc_name
    vpc_id = module.network.vpc_output.vpc_id
    vpc_cidr_block = module.network.vpc_output.vpc_cidr_block
  }
}