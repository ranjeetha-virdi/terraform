provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "myserver" {
  ami                    = "ami-009c5f630e96948cb"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web.id]
  tags = {
    Name  = "My Webserver"
    Owner = "Ranjeetha R"
  }


  provisioner "remote-exec" {


    inline = [
      "mkdir/home/ec2-user/terraform", #create a terraform folder
      "cd/home/ec2-user/terraform",
      "touch Hello.txt",
      "echo 'Terraform was here...'> terraform.txt"

    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      host        = self.public_ip //*same as = aws_instance.myserver.public_ip
      private_key = file("ranjeetha.pem")
    }
  }

}

resource "aws_security_group" "web" {
  name = "My Security Group"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
