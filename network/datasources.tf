data "aws_route_table" "route_table_name" {
  count = length(var.route_table_name_association)
    filter {
        name   = "tag:Name"
        values = [var.route_table_name_association[count.index]]
    }

    depends_on = [
      aws_route_table.route_tables
    ]
}