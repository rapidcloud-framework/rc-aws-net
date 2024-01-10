resource "aws_vpc_endpoint" "s3_endpoint" {
  count        = var.service == "s3" ? 1 : 0
  vpc_id       = var.vpc_id
  service_name = "com.amazonaws.${var.region}.s3"
  tags         = merge(local.rc_tags, var.tags)
}

resource "aws_vpc_endpoint_route_table_association" "s3_endpoint" {
  for_each        = var.service == "s3" ? var.route_tables : {}
  route_table_id  = each.value
  vpc_endpoint_id = aws_vpc_endpoint.s3_endpoint[0].id
}


