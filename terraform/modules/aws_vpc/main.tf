resource "aws_vpc" "vpc" {
  cidr_block                           = var.cidr
  enable_network_address_usage_metrics = true
  enable_dns_hostnames                 = var.enable_dns_hostnames == "true" ? true : false
  enable_dns_support                   = var.enable_dns_support == "true" ? true : false

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

