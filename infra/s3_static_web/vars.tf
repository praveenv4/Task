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
  default = ["0.0.0.0/0"]
}
variable "tags" {
  type = map
  description = "Common tags you want applied to all components."
}
