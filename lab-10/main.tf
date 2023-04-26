provider "aws" {
  region = "us-west-2"
}

resource "aws_db_instance" "prod" {
  identifier           = "prod-mysql-rds"
  allocated_storage    = 20
  storage_type         = "gp2"
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  apply_immediately    = true
  username             = "foo"
  password             = data.aws_secretsmanager_secret_version.rds_password.secret_string
}

#Generate Password

resource "random_password" "main" {
  length           = 20
  special          = true
  override_special = "#!()_"
}


#Store Password in SecretsManager

resource "aws_secretsmanager_secret" "rds_password" {
  name                    = "/prod/rds/password"
  description             = "Master Password for RDS DB"
  recovery_window_in_days = 0
}

#Retrive Password

resource "aws_secretsmanager_secret_version" "rds_password" {

  secret_id     = aws_secretsmanager_secret.rds_password.id
  secret_string = random_password.main.result

}

#Store all details of RDS in SecretsManager

resource "aws_secretsmanager_secret" "rds" {
  name                    = "/prod/rds/all"
  description             = "Store all details for RDS DB in Secrets Manager"
  recovery_window_in_days = 0
}

#Retrive all details

resource "aws_secretsmanager_secret_version" "rds" {

  secret_id = aws_secretsmanager_secret.rds.id
  secret_string = jsonencode({
    rds_address  = aws_db_instance.prod.address
    rds_port     = aws_db_instance.prod.port
    rds_username = aws_db_instance.prod.username
    rds_password = random_password.main.result
  })

}



data "aws_secretsmanager_secret_version" "rds" {
  secret_id  = aws_secretsmanager_secret.rds.id
  depends_on = [aws_secretsmanager_secret_version.rds]
}




data "aws_secretsmanager_secret_version" "rds_password" {
  secret_id  = aws_secretsmanager_secret.rds_password.id
  depends_on = [aws_secretsmanager_secret_version.rds_password]
}

########################################### outputs ###############################################

output "rds_address" {
  value = jsondecode(data.aws_secretsmanager_secret_version.rds.secret_string)["rds_address"]
}

output "rds_port" {
  value = jsondecode(data.aws_secretsmanager_secret_version.rds.secret_string)["rds_port"]
}

output "rds_username" {
  value = jsondecode(data.aws_secretsmanager_secret_version.rds.secret_string)["rds_username"]
}

output "rds_password" {
  value = jsondecode(data.aws_secretsmanager_secret_version.rds.secret_string)["rds_password"]
}

output "rds_all" {
  value = jsondecode(data.aws_secretsmanager_secret_version.rds.secret_string)
}
