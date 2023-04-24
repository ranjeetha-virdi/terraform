provider "aws"{
	region = "us-west-2"
}

resource "aws_instance" "my_ubuntu" {
  ami           = "ami-02d5619017b3e5162"
  instance_type = "t3.micro"
	key_name = "ranjeetha"

  tags = {
    Name = "my_ubuntu_server"
    Owner = "Ranjeetha R"
		project = "Munich"
  }
}

resource "aws_instance" "my_amazon" {
  ami           = "ami-02d5619017b3e5162"
  instance_type = "t3.small"

  tags = {
    Name = "my_amazonLinux_server"
    Owner = "Ranjeetha R"
  }
}
