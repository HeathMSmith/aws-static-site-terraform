resource "aws_s3_bucket" "site" {
  bucket = var.site_bucket_name
  tags   = var.tags
}

resource "aws_s3_bucket_public_access_block" "site" {
  bucket                  = aws_s3_bucket.site.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "site" {
  bucket = aws_s3_bucket.site.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "site" {
  bucket = aws_s3_bucket.site.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
locals {
  site_files = [
    for f in fileset(var.site_source_path, "**") :
    f if !endswith(f, ".DS_Store")
  ]
}

resource "aws_s3_object" "site_files" {
  for_each = { for file in local.site_files : file => file }

  bucket = aws_s3_bucket.site.id
  key    = each.value
  source = "${var.site_source_path}/${each.value}"
  etag   = filemd5("${var.site_source_path}/${each.value}")

  content_type = lookup({
    html = "text/html"
    css  = "text/css"
    js   = "application/javascript"
    png  = "image/png"
    jpg  = "image/jpeg"
    jpeg = "image/jpeg"
    svg  = "image/svg+xml"
    json = "application/json"
    ico  = "image/x-icon"
  }, split(".", each.value)[length(split(".", each.value)) - 1], "application/octet-stream")
}