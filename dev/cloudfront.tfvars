# Configurações CloudFront
cloudfront_enabled             = true
cloudfront_is_ipv6_enabled     = true
cloudfront_default_root_object = "index.html"

cloudfront_allowed_methods = ["GET", "HEAD", "OPTIONS"]
cloudfront_cached_methods = ["GET", "HEAD"]

cloudfront_viewer_protocol_policy = "redirect-to-https"

cloudfront_min_ttl     = 0
cloudfront_default_ttl = 3600
cloudfront_max_ttl     = 86400
