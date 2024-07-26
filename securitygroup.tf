resource "aws_security_group" "allow-ssh" {
  vpc_id      = data.aws_vpc.default.id
  name        = "allow-ssh"
  description = "security group that allows ssh and all egress traffic"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-ssh"
  }
}


resource "aws_security_group" "webserver-sg" {
  vpc_id = data.aws_vpc.default.id
  name   = "webserver-securitygrp"

  ingress {
    protocol    = "tcp"
    from_port   = 8000
    to_port     = 8000
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 8080
    to_port     = 8080
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "webserver-sg"
  }
}





