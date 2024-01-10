resource "aws_internet_gateway" "this" {
  vpc_id = var.vpc_id
  tags = merge(var.tags, {
    Name     = "${var.profile}-${var.name}"
    env      = var.env
    profile  = var.profile
    author   = "rapid-cloud"
    fqn      = var.fqn
    cmd_id   = var.cmd_id
    workload = var.workload
  })
}


resource "aws_route" "to_igw" {
  for_each               = var.route_tables
  route_table_id         = each.value
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

output "id" { value = aws_internet_gateway.this.id }
