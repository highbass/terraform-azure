module "resourcegroup" {
  source = "./../../modules/ResourceGroup"
  environment = "${var.environment}"
  appname = "${var.appName}"
  rg_name = "${var.appName}_${var.environment}"
  rg_region = "${var.region}"
}
