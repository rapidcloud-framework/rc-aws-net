locals {
  rc_tags = {
    Name     = "${var.profile}-${var.name}"
    env      = var.env
    profile  = var.profile
    author   = "rapid-cloud"
    fqn      = var.fqn
    cmd_id   = var.cmd_id
    workload = var.workload
    vpc      = var.vpc_id
  }
}
