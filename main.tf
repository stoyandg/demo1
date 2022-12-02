provider "aws" {
    region = var.region
}

module "ec2" {
    source = "./modules/ec2"
    subnet_id = var.subnet_id
    vpc_security_group_ids = var.vpc_security_group_ids
}