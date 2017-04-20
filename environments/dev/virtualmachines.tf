 module "availabilityset" {
   source = "./../../modules/availabilityset"
   environment = "${var.environment}"
   appname = "${var.appName}"

   as_name = "cassandra"
   as_region = "${var.region}"
   as_resourcegroup = "${module.resourcegroup.name}"
 }

module "sg_cassandra" {
  source = "./../../modules/securitygroup/cassandra"
  environment = "${var.environment}"
  appname = "${var.appName}"
  sg_region = "${var.region}"
  sg_resourcegroup = "${module.resourcegroup.name}"
}

module "seedNodes" {
  source = "./../../modules/virtualmachine"
  environment = "${var.environment}"
  appname = "${var.appName}"

  vm_count = "${var.number_of_seed_nodes}"
  vm_name = "cassandra-seed"
  vm_type = "seednode"
  vm_region = "${var.region}"
  vm_resourcegroup = "${module.resourcegroup.name}"
  vm_subnetid = "${module.subnet.id}"
  vm_securitygroup = "${module.sg_cassandra.id}"

  vm_machine_type = "Standard_DS11_v2"

  vm_availabilityset = "${module.availabilityset.id}"

  vm_username = "${var.username}"
  vm_password = "${var.password}"
}

module "dataNodes" {
  source = "./../../modules/virtualmachine"
  environment = "${var.environment}"
  appname = "${var.appName}"

  vm_count = "${var.number_of_data_nodes}"
  vm_name = "cassandra-data"
  vm_type = "datanode"
  vm_region = "${var.region}"
  vm_resourcegroup = "${module.resourcegroup.name}"
  vm_subnetid = "${module.subnet.id}"
  vm_securitygroup = "${module.sg_cassandra.id}"

  vm_machine_type = "Standard_DS11_v2"

  vm_availabilityset = "${module.availabilityset.id}"

  vm_username = "${var.username}"
  vm_password = "${var.password}"
}
