terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.84.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "tf_s3_bucket_rizwan" {
  bucket = "tf-s3-bucket-24012025" # Updated to follow S3 bucket naming rules
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.tf_s3_bucket_rizwan.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
/*
resource "aws_s3_bucket_policy" "tf_s3_bucket_rizwan" {
    bucket = aws_s3_bucket.tf_s3_bucket_rizwan.id
    policy = jsondecode(
        {
        Version = "2012-10-17",
        Statement = [
    {
        Sid = "Stmt1737915234567",
        Action = "s3:GetObject"
        Effect = "Allow",
        Resource = "arn:aws:s3:::tf-s3-bucket-24012025",
        Principal = "*"
    }
  ]
        }

    )
  
}
*/
resource "aws_s3_bucket_policy" "tf_s3_bucket_rizwan" {
  bucket = aws_s3_bucket.tf_s3_bucket_rizwan.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "Stmt1737915234567"
        Action    = "s3:GetObject"
        Effect    = "Allow"
        Resource  = "arn:aws:s3:::tf-s3-bucket-24012025/*"
        Principal = "*"
      }
    ]
  })
}

resource "aws_s3_bucket_website_configuration" "tf_s3_bucket_rizwan" {
  bucket = aws_s3_bucket.tf_s3_bucket_rizwan.id

  index_document {
    suffix = "index.html"
  }
}







resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.tf_s3_bucket_rizwan.bucket
  source = "./index.html" # Ensure this file exists in your working directory
  key    = "index.html"
  content_type = "text/html"
}



resource "aws_s3_object" "style_css" {
  bucket = aws_s3_bucket.tf_s3_bucket_rizwan.bucket
  source = "./style.css" # Ensure this file exists in your working directory
  key    = "style.css"
  content_type = "text/css"
}


output "name" {
    value= aws_s3_bucket_website_configuration.tf_s3_bucket_rizwan.website_endpoint
  
}