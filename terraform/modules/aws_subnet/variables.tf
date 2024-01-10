variable "name" {}
variable "env" {}
variable "profile" {}
variable "workload" {}
variable "fqn" {}
variable "cmd_id" { default = "" }

variable "vpc_id" {}
variable "az" {}
variable "cidr" {}
variable "associate_route_table" {}
variable "create_route_table" {}
variable "tags" { default = {} }
