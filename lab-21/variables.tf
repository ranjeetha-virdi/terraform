variable "aws_users" {
  description = "List of IAM users to create"
  default = [
    "ranjeetha@net.com",
    "preet@singh.com",
    "kul@singh.com",
    "kulpreet@singh.com"
  ]
}


variable "server_settings" {
  type = map(any)

  default = {
    web = {
      ami           = "ami-04e914639d0cca79a"
      instance_type = "t2.small"
      root_disksize = 20
      encrypted     = true
    }
    app = {
      ami           = "ami-04adeb9ef364bcb6a"
      instance_type = "t3.micro"
      root_disksize = 33
      encrypted     = false
    }
  }
}

variable "create_bastion" {

  description = "Provision Bastion Server Yes/No"
  default     = "Yes"
}
