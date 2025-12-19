resource "aws_s3_bucket" "bucket_frontend" {
  bucket = var.bucket_name
  tags   = var.tags
}

resource "aws_s3_bucket_public_access_block" "bucket_frontend" {
  bucket = aws_s3_bucket.bucket_frontend.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Política do bucket S3 para permitir acesso apenas pelo CloudFront OAC
data "aws_iam_policy_document" "origin_bucket_policy" {
  for_each = var.create_cloudfront_policy ? toset(["policy"]) : toset([])

  statement {
    sid    = var.policy_statement_sid
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    actions = var.bucket_policy_actions

    resources = [
      "${aws_s3_bucket.bucket_frontend.arn}/*",
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [var.cloudfront_distribution_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  for_each = var.create_cloudfront_policy ? toset(["policy"]) : toset([])
  bucket   = aws_s3_bucket.bucket_frontend.id
  policy   = data.aws_iam_policy_document.origin_bucket_policy[each.key].json
}
