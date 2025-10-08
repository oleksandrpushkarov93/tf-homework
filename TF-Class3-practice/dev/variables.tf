variable "allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = number
  
}
variable "engine_version" {
  description = "The version of the database engine"
  type        = string
  
}
variable "instance_class" {
  description = "The instance type of the RDS instance"
  type        = string          
}
variable "port" {
  description = "The port on which the database accepts connections"
  type        = number
}
variable "cidr_block" {
  description = "The CIDR blocks to allow access from"
  type        = string
}


