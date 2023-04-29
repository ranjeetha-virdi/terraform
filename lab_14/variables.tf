variable "aws_region" {
  description = "Region where you want to provision this EC2 WebServer"
  type        = string // number , bool
  default     = "us-west-2"
}

variable "port_list" {
  description = "List of Poret to open for our WebServer"
  type        = list(any)
  default     = ["80", "443"]
}

variable "instance_size" {
  description = "EC2 Instance Size to provision"
  type        = string
  default     = "t3.micro"
}

variable "tags" {
  description = "Tags to Apply to Resources"
  type        = map(any)
  default = {
    Owner       = "Ranjeetha R"
    Environment = "Staging"
    Project     = "Phoenix"
  }
}

#Variable Declaration
variable "public_key" {
  type    = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCEYecSJr7c19e+aqSEs5pjarhdK7Uht9s-*"
}

#Variable Declaration
variable "key_pair_name" {
  type    = string
  default = "terraformpair"
}



variable "key_pair" {
  description = "SSH Key pair name to ingest into EC2"
  type        = string

  sensitive = true
}

variable "password" {
  description = "Please Enter Password lenght of 10 characters!"
  type        = string
  sensitive   = true
  validation {
    condition     = length(var.password) == 10
    error_message = "Your Password must be 10 characted exactly!!!"
  }
}
