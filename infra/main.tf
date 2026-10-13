provider "aws" {
  region = "ap-south-1"
}

resource "aws_security_group" "devops_sg" {
  name = "devops-mini-sg"
  ingress {
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "devops_ec2" {
  ami = "ami-0e35ddab05955cf7f" # Amazon Linux 2023 ap-south-1
  instance_type = "t2.medium"
  vpc_security_group_ids = [aws_security_group.devops_sg.id]
  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install docker git -y
    systemctl start docker
    usermod -aG docker ec2-user
    curl -sfL https://get.k3s.io | sh -
  EOF
  tags = { Name = "DevOps-Mini-Project" }
}
