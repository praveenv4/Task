# S3 bucket for website.
resource "aws_s3_bucket" "codebucket" {
  bucket = "${var.bucket_name}"
  acl = "private"
  policy = templatefile("${path.module}/templates/s3-policy.json", { bucket = "${var.bucket_name}", arn = "${aws_cloudfront_origin_access_identity.s3_distribution.iam_arn}" })

  cors_rule {
    allowed_headers = ["Authorization", "Content-Length"]
    allowed_methods = ["GET", "POST"]
    allowed_origins = ["http://${var.domain_name}"]
    max_age_seconds = 3000
  }

  website {
    index_document = "index.html"
    error_document = "404.html"
  }

  tags = "${var.tags}"
}
