resource "random_string" "random" {
  length           = 16
  special          = false
}

resource "aws_wafv2_ip_set" "ipset" {
  name = "IPSet-${random_string.random.result}"
  scope = "CLOUDFRONT"
  ip_address_version = "IPV4"
  addresses = "${var.waf_whitelisted_ip_list}"

  tags = var.tags
}

resource "aws_wafv2_web_acl" "webacl" {
  name        = "webacl-${random_string.random.result}"
  description = "web acl for s3 bucket ${var.bucket_name}"
  scope       = "CLOUDFRONT"
  default_action {
    allow {}
  }
  rule {
    name     = "ip-whitelisting"
    priority = 1

    action {
      block {}
    }

     statement {
      ip_set_reference_statement {
        arn = aws_wafv2_ip_set.ipset.arn
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "ip-whitelisting-${random_string.random.result}"
      sampled_requests_enabled   = false
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = "metric2-${random_string.random.result}"
    sampled_requests_enabled   = false
  }
}
