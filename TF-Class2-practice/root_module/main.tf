module "EC2" {
  source        = "../ec2"
  ami           = var.ami
  instance_type = var.instance_type
}

module "VPC" {
  source   = "../vpc"
  vpc_cidr = var.vpc_cidr
}

