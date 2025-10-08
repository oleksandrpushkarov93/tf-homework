resource "aws_security_group" "allow_mysql" {
  name        = "allow_mysql"
  description = "Allow mysql traffic and all outbound traffic"
    vpc_id      = aws_vpc.allow_mysql.id
    
}

resource "aws_vpc" "allow_mysql" {
  instance_tenancy = "default"
  cidr_block      = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true


  tags = {
    Name = "allow_mysql"
  }
}

data "aws_subnets" "vpc_subnets" {
  filter {
    name   = "vpc-id"
    values = [aws_vpc.allow_mysql.id]
  }
}

resource "aws_db_subnet_group" "my_subnets" {
  name       = "my-db-subnet-group"
  subnet_ids = data.aws_subnets.vpc_subnets.ids

  tags = {
    Name = "my-db-subnet-group"
  }
}

resource "aws_security_group_rule" "allow_mysql_ingress" {
  type              = "ingress"
  from_port         = var.port
  to_port           = var.port
  protocol          = "tcp"
  cidr_blocks       = [var.cidr_block]
  security_group_id = aws_security_group.allow_mysql.id
}
  


 

  resource "aws_security_group_rule" "allow_all_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.allow_mysql.id
}

resource "aws_subnet" "db_subnet" {
  count                   = 2
  vpc_id                  = aws_vpc.allow_mysql.id
  cidr_block              = cidrsubnet(var.cidr_block, 4, count.index) # generates two subnets
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "db-subnet-${count.index}"
  }
}

data "aws_availability_zones" "available" {}