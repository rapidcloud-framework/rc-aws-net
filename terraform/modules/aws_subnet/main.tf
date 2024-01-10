resource "aws_subnet" "this" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.cidr
  availability_zone       = var.az
  map_public_ip_on_launch = true
  tags = merge(
    {
      Name     = "${var.profile}-${var.name}"
      az       = var.az
      env      = var.env
      profile  = var.profile
      author   = "rapid-cloud"
      fqn      = var.fqn
      cmd_id   = var.cmd_id
      workload = var.workload
    }, var.tags
  )
  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_route_table" "this" {
  count  = var.create_route_table == "true" ? 1 : 0
  vpc_id = var.vpc_id

  tags = merge({
    Name     = "${var.profile}-${var.name}"
    az       = var.az
    env      = var.env
    profile  = var.profile
    author   = "rapid-cloud"
    fqn      = var.fqn
    workload = var.workload
  }, var.tags)
}


output "route_table_id" { value = var.create_route_table == "true" ? aws_route_table.this[0].id : "none" }
output "id" { value = aws_subnet.this.id }

resource "aws_route_table_association" "this" {
  route_table_id = var.create_route_table == "true" ? aws_route_table.this[0].id : var.associate_route_table
  subnet_id      = aws_subnet.this.id
}
