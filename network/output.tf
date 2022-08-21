output "vpc_output" {
  value = {
    vpc_name = aws_vpc.main.tags.Name
    vpc_id = aws_vpc.main.id
    vpc_cidr_block = aws_vpc.main.cidr_block
  }
}