provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "my_server" {
  count         = 4
  ami           = "ami-009c5f630e96948cb"
  instance_type = "t3.micro"
  tags = {
    name = "My Server ${count.index + 1}"
  }
}

resource "aws_iam_user" "user" {
  count = length(var.aws_users)
  name  = element(var.aws_users, count.index)
}

resource "aws_instance" "bastion_server" {
  count         = var.create_bastion == "Yes" ? 1 : 0
  ami           = "ami-009c5f630e96948cb"
  instance_type = "t3.micro"
  tags = {
    name  = "bastion server"
    owner = "ranjeetha r"
  }
}
