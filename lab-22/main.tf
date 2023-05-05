provider "aws" {
  region = "us-west-2"

}

resource "aws_iam_user" "user" {
  for_each = toset(var.aws_users)
  name     = each.value

}

resource "aws_instance" "my_server" {
  count         = 4
  ami           = "ami-04e914639d0cca79a"
  instance_type = "t3.micro"
  tags = {
    name  = "My Server"
    owner = "RR"
  }
}
