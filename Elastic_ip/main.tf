
provider "aws" {
  region = "us-west-2"
}



resource "aws_default_vpc" "default" {} # This need to be added since AWS Provider v4.29+ to get VPC id


resource "aws_eip" "web" {
  instance = aws_instance.web.id
  tags = {
    name  = "Elastic IP for Web Server"
    owner = "Ranjeetha R"
  }

}

resource "aws_instance" "web" {
  ami                         = "ami-0ac64ad8517166fb1"
  instance_type               = "t3.micro"
  vpc_security_group_ids      = [aws_security_group.web.id]
  user_data                   = file("user_data.sh") // Static File
  user_data_replace_on_change = true

  tags = {
    name  = "Web Server Built by Terraform"
    owner = "Ranjeetha R"
  }

  lifecycle {
    create_before_destroy = true
  }
}



resource "aws_security_group" "web" {
  name        = "Webserver-SG"
  description = "Security group for my Webserver"
  vpc_id      = aws_default_vpc.default.id # This need to be added since AWS Provider v4.29+ to set VPC id


  dynamic "ingress" {
    for_each = ["80", "443"]
    content {
      description = "Allow port HTTP"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

  }

  egress {
    description = "Allow all ports"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]


  }

  tags = {
    Name  = "WebServer SG by Terraform"
    Owner = "Ranjeetha r"
  }
}




