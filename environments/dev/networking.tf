module "virtualnetwork" {
  source = "./../../modules/virtualnetwork"
  environment = "${var.environment}"
  appname = "${var.appName}"
  vn_name = "${var.appName}_${var.environment}"
  vn_region = "${var.region}"
  vn_blocks = "${var.address_space}"
  vn_resourcegroup = "${module.resourcegroup.name}"
}

module "subnet" {
  source = "./../../modules/subnet"
  sn_vn_name = "${module.virtualnetwork.name}"
  sn_subnet = "${var.subnets}"
  sn_subnet_names = "${var.subnet_names}"
  sn_resourcegroup = "${module.resourcegroup.name}"
}
