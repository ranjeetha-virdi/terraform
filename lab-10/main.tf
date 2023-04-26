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

data "aws_secretsmanager_secret_version" "rds_password" {
  secret_id  = aws_secretsmanager_secret.rds_password.id
  depends_on = [aws_secretsmanager_secret_version.rds_password]
}

########################################### outputs ###############################################

output "rds_address" {
  value = aws_db_instance.prod.address
}

output "rds_port" {
  value = aws_db_instance.prod.port
}

output "rds_username" {
  value = aws_db_instance.prod.username
}

output "rds_password" {
  value     = random_password.main.result
  sensitive = true
}
