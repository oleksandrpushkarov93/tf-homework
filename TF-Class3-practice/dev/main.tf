module "myapp_module" {
  source = "../myapp_module"

    allocated_storage = var.allocated_storage
    engine_version    = var.engine_version
    instance_class    = var.instance_class
    port              = var.port
    cidr_block    = var.cidr_block
    
}
