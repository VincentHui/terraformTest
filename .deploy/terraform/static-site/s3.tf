resource "aws_s3_bucket" "website_bucket" {
  bucket = var.domain_name
  acl    = "public-read"
  policy = data.aws_iam_policy_document.website_policy.json
  website {
    index_document = "index.html"
    error_document = "index.html"
  }
}

resource "aws_s3_bucket" "website_bucket_subdomain" {
  bucket = "www.${var.domain_name}"
  acl    = "public-read"
  policy = data.aws_iam_policy_document.website_policy_subdomain.json
  website{
    redirect_all_requests_to = var.domain_name
  }
}

# resource "aws_s3_bucket_website_configuration" "example" {
#   #   bucket = aws_s3_bucket.example.id
#   bucket = "www.${var.domain_name}"

#   redirect_all_requests_to {
#     host_name = var.domain_name
#   }
# }