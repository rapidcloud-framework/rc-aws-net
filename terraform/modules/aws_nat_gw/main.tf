resource "aws_eip" "this" {
  vpc = true
  tags = {
    Name     = "${var.profile}-${var.name}-${var.subnet}"
    subnet   = var.subnet
    env      = var.env
    profile  = var.profile
    author   = "rapid-cloud"
    fqn      = var.fqn
    cmd_id   = var.cmd_id
    workload = var.workload
  }
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.this.id
  subnet_id     = var.subnet
  tags = merge(var.tags, {
    Name     = "${var.profile}-${var.name}-${var.subnet}"
    subnet   = var.subnet
    eip      = aws_eip.this.id
    env      = var.env
    profile  = var.profile
    author   = "rapid-cloud"
    fqn      = var.fqn
    workload = var.workload
  })
}


resource "aws_route" "to_natgw" {
  for_each               = var.route_tables
  route_table_id         = each.value
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.this.id
}

output "id" { value = aws_nat_gateway.this.id }
