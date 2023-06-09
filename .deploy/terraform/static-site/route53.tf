# .deploy/terraform/static-site/route53.tf
resource "aws_route53_zone" "primary" {
  name = var.domain_name
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.primary.zone_id
  name = var.domain_name
  type = "A"
  alias {
    name = aws_s3_bucket.website_bucket.website_domain
    zone_id = aws_s3_bucket.website_bucket.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "subdomain" {
  zone_id = aws_route53_zone.primary.zone_id
  name = "www"
  type = "A"
  alias {
    name = aws_s3_bucket.website_bucket_subdomain.website_domain
    zone_id = aws_s3_bucket.website_bucket_subdomain.hosted_zone_id
    evaluate_target_health = false
  }
}