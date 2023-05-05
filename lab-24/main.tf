provider "aws" {
  region = "us-west-1"

}

provider "aws" {
  region = "us-west-2"
  alias  = "dev"
  assume_role {
    role_arn = "arn:aws:iam::032823347814:role/TerraformRole"
  }
}

provider "aws" {
  region = "us-east-1"
  alias  = "prod"
  assume_role {
    role_arn = "arn:aws:iam::639130796919:role/TerraformRole"
  }
}

#---------------------------------------------------------------
#---------------------------------------------------------------

resource "aws_vpc" "master_vpc" {
  cidr_blocks = "10.0.0.0/16"
  tags = {
    name = "Master VPC"
  }
}

resource "aws_vpc" "dev_vpc" {
  provider    = aws.dev
  cidr_blocks = "10.0.0.0/16"
  tags = {
    name = "Dev VPC"
  }
}

resource "aws_vpc" "name" {
  provider    = aws.prod
  cidr_blocks = "10.0.0.0/16"
  tags = {
    name = "Prod VPC"
  }

}
