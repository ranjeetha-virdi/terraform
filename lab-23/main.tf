
#### Create Resources in multiple AWS Regions ####

provider "aws" {

  region = "us-west-2"

}


//If we want to create infrastructure in different regions then 
//step : Configure additional provider
// as we cannot have two aws providers hence use the term alias
provider "aws" {
  region = "us-west-1"
  alias  = "California"

}

provider "aws" {
  region = "us-east-1"
  alias  = "Virginia"

}



#----------------------------------------------------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------------------------------------------------
data "aws_ami" "default_latest_ubuntu20" {

  owners      = ["099720109477"] //ami : Owner account ID
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"] //ami name
  }
}


data "aws_ami" "California_latest_ubuntu20" {
  provider    = aws.California
  owners      = ["099720109477"] //ami : Owner account ID
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"] //ami name
  }
}

data "aws_ami" "Virginia_latest_ubuntu20" {
  provider    = aws.Virginia
  owners      = ["099720109477"] //ami : Owner account ID
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"] //ami name
  }
}



#----------------------------------------------------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------------------------------------------------


resource "aws_instance" "my_default_server" {
  instance_type = "t3.micro"
  ami           = data.aws_ami.default_latest_ubuntu20.id
  tags = {
    name = "Default Server"
  }

}



resource "aws_instance" "my_california_server" {
  provider      = aws.California
  instance_type = "t3.micro"
  ami           = data.aws_ami.California_latest_ubuntu20.id
  tags = {
    name = "California Server"
  }

}

resource "aws_instance" "my_virginia_server" {
  provider      = aws.Virginia
  instance_type = "t3.micro"
  ami           = data.aws_ami.Virginia_latest_ubuntu20.id
  tags = {
    name = "Virginia Server"
  }

}
