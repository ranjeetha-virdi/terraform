provider "aws" {
  region = "eu-west-1"
}


data "aws_ami" "latest_ubuntu20" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

data "aws_ami" "latest_amazonlinux" {
  owners      = ["137112412989"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

data "aws_ami" "latest_windowserver2019" {
  owners      = ["801119661308"]
  most_recent = true
  filter {
    name   = "name"
    values = ["Windows_Server-2022-English-Core-Base-*"]
  }
}

output "ubuntu20" {
  value = data.aws_ami.latest_ubuntu20.id
}

output "windows_server" {
  value = data.aws_ami.latest_windowserver2019.id
}

output "amazonlinux" {
  value = data.aws_ami.latest_amazonlinux.id
}

