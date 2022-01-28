# Cloudfront distribution for main s3 site.
resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = "${aws_s3_bucket.codebucket.website_endpoint}"
    origin_id = "S3-www.${var.bucket_name}"

    custom_origin_config {
      http_port = 80
      https_port = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }
  }
#  aliases = [var.domain_name]
  enabled = true
  is_ipv6_enabled = true
  default_root_object = "index.html"

  custom_error_response {
    error_caching_min_ttl = 0
    error_code = 404
    response_code = 200
    response_page_path = "/404.html"
  }
  default_cache_behavior {
    allowed_methods = ["GET", "HEAD"]
    cached_methods = ["GET", "HEAD"]
    target_origin_id = "S3-www.${var.bucket_name}"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl = 31536000
    default_ttl = 31536000
    max_ttl = 31536000
    compress = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  web_acl_id = aws_wafv2_web_acl.webacl.arn

  tags = var.tags

}

resource "aws_cloudfront_origin_access_identity" "s3_distribution" {
  comment = "OAI for cloudfront s3 bucket"
}