variable "subnet_id" {}

variable "vpc_security_group_ids" {}

variable "instance_type" {
    type = string
    default = "t2.micro"
}