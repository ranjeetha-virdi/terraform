variable "env" {

  default = "test"
}

variable "server_size" {

  default = {
    prod       = "t2.micro"
    staging    = "t2.micro"
    dev        = "t3.micro"
    my_default = "t3.nano"
  }
}

variable "ami_id_per_region" {
  description = "My custom AMI id per region."
  default = {
    "us-west-2" = "ami-009c5f630e96948cb"
    "us-west-1" = "ami-009c5f630e96948cb"
    "us-east-2" = "ami-0578f2b35d0328762"
    "us-east-1" = "ami-02396cdd13e9a1257"
  }
}

variable "allow_port" {

  default = {
    prod = ["80", "443"]
    rest = ["80", "443", "8080", "22"]
  }
}
