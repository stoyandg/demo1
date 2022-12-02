variable "region" {
    type = string
    default = "eu-central-1"
}

variable "vpc_id" {
    default = "vpc-0bc375671e9e83f34"
}

variable "subnet_id" {
    default = "subnet-0eac2b227f37790fd"
}

variable "vpc_security_group_ids" {
    type = map(list(string))
    default = {
        "main" = ["sg-0df7c88138d66efdb"]
        "secondary" = ["sg-009d09f65e6e24aae"]
    }
}