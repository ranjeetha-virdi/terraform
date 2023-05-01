provider "aws" {
  region = "us-west-2"
}

data "aws_region" "current" {}
data "aws_availability_zones" "available" {}

locals {
  region_fullname   = data.aws_region.current.description
  number_of_AZs     = length(data.aws_availability_zones.available.names)
  names_of_AZs      = join(",", data.aws_availability_zones.available.names)
  full_project_name = "${var.project_name} running in ${local.region_fullname}"
}

locals {
  tags_for_eip = {
    Enviornment  = var.enviornment
    Region_full  = local.region_fullname
    Project_name = local.full_project_name


  }
}


locals {
  Region_Info    = "This resource is in ${data.aws_region.current.description} consist of ${length(data.aws_availability_zones.available.names)} AZs"
  Region_info_v2 = "This resource is in ${local.region_fullname} consist of ${local.number_of_AZs} AZs"
}


resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name        = "My VPC"
    Region_Info = local.Region_Info
    Region_Info = local.Region_info_v2
    AZ_names    = local.names_of_AZs
  }
}

resource "aws_eip" "my_static_ip" {
  tags = merge(var.tags, local.tags_for_eip, {
    Name        = "My EIP"
    Region_Info = local.Region_Info
  })
}
