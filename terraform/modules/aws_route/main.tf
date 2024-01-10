resource "aws_route" "tgw" {
  for_each               = var.transit_gateway_id != "" ? toset(var.route_tables) : []
  route_table_id         = each.key
  destination_cidr_block = var.destination_cidr_block
  transit_gateway_id     = var.transit_gateway_id
}

resource "aws_route" "peering" {
  for_each                  = var.vpc_peering_connection_id != "" ? toset(var.route_tables) : []
  route_table_id            = each.key
  destination_cidr_block    = var.destination_cidr_block
  vpc_peering_connection_id = var.vpc_peering_connection_id
}
