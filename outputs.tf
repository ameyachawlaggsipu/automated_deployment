output "s3_bucket_name" {
  value = aws_s3_bucket.portfolio_website_bucket.id
}

output "cloudfront_distribution_domain_name" {
  value = aws_cloudfront_distribution.cloud_front.domain_name
}