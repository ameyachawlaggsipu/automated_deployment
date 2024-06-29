terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-2"
}

# Declaring Bucket Name
resource "aws_s3_bucket" "portfolio_website_bucket" {
  bucket = "my-portfolio-website-bucket-ml-ai"
}

resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.portfolio_website_bucket.id
  key    = "index.html"
  source = "website_code/index.html"
  etag   = filemd5("website_code/index.html")
  content_type = "text/html"
}

resource "aws_cloudfront_origin_access_identity" "origin" {
  comment = "Origin for portfolio website"
}

resource "aws_cloudfront_distribution" "cloud_front" {
  origin {
    domain_name = aws_s3_bucket.portfolio_website_bucket.bucket_regional_domain_name
    origin_id   = "my-portfolio-website-bucket"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.origin.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "my-portfolio-website-bucket"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.portfolio_website_bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "s3:GetObject"
        Effect   = "Allow"
        Resource = "${aws_s3_bucket.portfolio_website_bucket.arn}/*"
        Principal = {
          CanonicalUser = aws_cloudfront_origin_access_identity.origin.s3_canonical_user_id
        }
      }
    ]
  })
}
