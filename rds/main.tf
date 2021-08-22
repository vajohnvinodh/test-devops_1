provider "aws" {

        region = "us-east-1"
}

resource "aws_db_instance" "my-sql-db" {
  identifier	       = "mysqldatabase"
  storage_type	       = "gp2"
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t2.micro"
  db_subnet_group_name = "${var.mysubgrouid}"
  name                 = "mydb"
  username             = "foo"
  password             = "foobarbaz"
  parameter_group_name = "default.mysql8.0"
  vpc_security_group_ids = ["${var.mypvtsecgroupid}"]
 #  availability_zone    = "us-east-1a"
  multi_az	       = true
  skip_final_snapshot  = true

tags = {
  Name 			= "Test-Devops"
}
}
