variable "name" {}
variable "env" {}
variable "profile" {}
variable "workload" {}
variable "fqn" {}
variable "cmd_id" { default = "" }

variable "cidr" {}
variable "enable_dns_support" {}
variable "enable_dns_hostnames" {}
variable "tags" { default = {} }
