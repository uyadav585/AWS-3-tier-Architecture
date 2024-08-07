variable "database_private_subnet_id" {}
variable "database_private_subnet_id_1b" {}
variable "database_sg_id" {}
variable "tomcat_sg_id" {}


resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = [var.database_private_subnet_id, var.database_private_subnet_id_1b]

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_db_instance" "default" {
  allocated_storage    = 20
  vpc_security_group_ids = [var.tomcat_sg_id, var.database_sg_id]
  db_subnet_group_name = aws_db_subnet_group.default.name
  identifier           = "database-2"
  engine               = "mysql"
  engine_version       = "8.0.35"
  instance_class       = "db.t3.micro"
  username             = "admin"
  password             = "pass12345"
  parameter_group_name = "default.mysql8.0"
  multi_az             = false
  skip_final_snapshot  = true

  tags = {
    Name = "Database-2"
  }
}
 output "database_name" {
   value = aws_db_instance.default.db_name
 }


 #got to make connection between tomcat and database!!!!!!!!!!