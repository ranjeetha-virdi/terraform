provider "aws" {
  region = "us-west-2"
}


resource "aws_default_vpc" "default" {}




resource "aws_instance" "my_server_Web" {
  ami           = "ami-0ac64ad8517166fb1"
  instance_type = "t3_micro"

  vpc_security_group_ids = [aws_security_group.general.id]
  tags                   = { Name = "Web_Server" }

  depends_on = [aws_instance.my_server_Db, aws_instance.my_server_App]


}





resource "aws_instance" "my_server_App" {
  ami           = "ami-0ac64ad8517166fb1"
  instance_type = "t3_micro"

  vpc_security_group_ids = [aws_security_group.general.id]
  tags                   = { Name = "App_Server" }


  depends_on = [aws_instance.my_server_Db]
}




resource "aws_instance" "my_server_Db" {
  ami           = "ami-0ac64ad8517166fb1"
  instance_type = "t3_micro"

  vpc_security_group_ids = [aws_security_group.general.id]
  tags                   = { Name = "App_Server" }
}




resource "aws_security_group" "general" {
  name   = "Security_Grop"
  vpc_id = aws_default_vpc.default.id


  dynamic "ingress" {

    for_each = ["80", "443", "22", "3389"]
    content {
      description = "for HTTP ports"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    description = "for all ports"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = { Name = "my_security_group" }
}
