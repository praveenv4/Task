#terraform vars
variable "aws_profile" {
  type = string
  description = "AWS profile"
}
variable "aws_region" {
  type = string
  default = "us-east-1"
  description = "AWS region"
}
variable "bucket_name" {
  type = string
  description = "The domain name for the website."
}
variable "domain_name" {
  type = string
  description = "The name of the bucket without the www. prefix. Normally domain_name."
}
variable "waf_whitelisted_ip_list" {
  type = list
  description = "List of IP addresses to be whitelisted in WAF"
  default = ["192.168.1.2/32"]
}
variable "tags" {
  type = map
  description = "Common tags you want applied to all components."
  default = {
    name = "project"
  }
}
