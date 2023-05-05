provider "aws" {
  region = "us-west-2"
}

resource "aws_iam_user" "user" {
  for_each = toset(var.aws_users)
  name     = each.value
}
resource "aws_instance" "my_server" {
  for_each      = toset(["Dev", "Staging", "Prod"])
  ami           = "ami-009c5f630e96948cb"
  instance_type = "t2.micro"
  tags = {
    Name  = "My Webserver- ${each.value}"
    Owner = "Ranjeetha R"
  }

}

resource "aws_instance" "server" {
  for_each      = var.server_settings
  ami           = each.value["ami"]
  instance_type = each.value["instance_type"]
  root_block_device {
    volume_size = each.value["root_disksize"]
    encrypted   = each.value["encrypted"]
  }
  volume_tags = {
    name = "Disk-${each.key}"
  }
  tags = {
    name  = "Server-${each.key}"
    owner = "RR"
  }
}

resource "aws_instance" "bastion_server" {
  for_each      = var.create_bastion == "Yes" ? toset(["bastion"]) : []
  ami           = "ami-009c5f630e96948cb"
  instance_type = "t2.micro"
  tags = {
    Name  = "My Webserver- ${each.value}"
    Owner = "Ranjeetha R"
  }


}
