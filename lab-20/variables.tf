variable "aws_users" {
  description = "List of IAM users to create"
  default = [
    "ranjeetha@net.com",
    "preet@singh.com",
    "kul@singh.com"
  ]
}


variable "create_bastion" {
  description = "Create Bastion server yes/no"
  value       = "Yes"
}
