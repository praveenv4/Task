#terraform template to deploy project a and project b
provider "aws" {
  profile = "${var.aws_profile}"
  region = "${var.aws_region}"
#  version = "3.63.0"
}

#calling terraform module s3_static_web
module "s3_static_web_deployment" {
  source = "./s3_static_web"
  bucket_name = "${var.bucket_name}"
  domain_name = "${var.domain_name}"
  waf_whitelisted_ip_list = "${var.waf_whitelisted_ip_list}"
  tags = "${var.tags}"
}
