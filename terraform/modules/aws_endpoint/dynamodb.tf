resource "aws_vpc_endpoint" "dynamodb_endpoint" {
  count        = var.service == "dynamodb" ? 1 : 0
  vpc_id       = var.vpc_id
  service_name = "com.amazonaws.${var.region}.dynamodb"
  tags         = merge(local.rc_tags, var.tags)
}

resource "aws_vpc_endpoint_route_table_association" "dynamodb_endpoint" {
  for_each        = var.service == "dynamodb" ? var.route_tables : {}
  route_table_id  = each.value
  vpc_endpoint_id = aws_vpc_endpoint.dynamodb_endpoint[0].id
}

