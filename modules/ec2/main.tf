data "aws_ami" "latest_amazon_linux" {
    owners = ["amazon"]
    most_recent = true
    filter {
        name = "name"
        values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]
    }
}


resource "aws_iam_instance_profile" "ec2-role" {
    name = "ec2-role"
    role = "ec2-role-for-s3-access"
}

resource "aws_instance" "JenkinsPreconfigured" {
    ami = "ami-045e34a36ab2c7a56"
    instance_type = var.instance_type
    subnet_id = var.subnet_id
    vpc_security_group_ids = var.vpc_security_group_ids["main"]
    iam_instance_profile = aws_iam_instance_profile.ec2-role.name
    key_name = "key-pair"
    
    connection {
        type = "ssh"
        host = "${aws_instance.JenkinsPreconfigured.public_ip}"
        user = "ec2-user"
        private_key = "${file("/home/stoyan/.ssh/key-pair.pem")}"
        timeout = "2m"
    }
    provisioner "remote-exec" {
        inline = [
            "aws s3 cp s3://my-cerebration-bucket/github /home/ec2-user/.ssh"
        ]
    }

    tags = {
        Name = "Jenkins Preconfigured Server"
    
    }
}
resource "aws_instance" "ApachePreconfigured" {
    ami = "ami-05f2dc328dcfc9ed6"
    instance_type = var.instance_type
    subnet_id = var.subnet_id
    vpc_security_group_ids = var.vpc_security_group_ids["main"]
    iam_instance_profile = aws_iam_instance_profile.ec2-role.name
    
    tags = {
        Name = "Apache Preconfigured Server"
    }
}