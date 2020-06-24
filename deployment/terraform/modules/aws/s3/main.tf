resource "aws_s3_bucket" "b" {
  bucket = var.bucket_name
  acl    = "public-read"
  policy = <<EOF
{
  "Version":"2012-10-17",
  "Statement":[{
        "Sid":"PublicReadForGetBucketObjects",
        "Effect":"Allow",
          "Principal": "*",
      "Action":["s3:GetObject"],
      "Resource":["arn:aws:s3:::${var.bucket_name}/*"]
    }
  ]
}
EOF

  force_destroy = true

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

resource "null_resource" "build" {
  provisioner "local-exec" {
    working_dir = "../../"
    command = "npm install && npm run deploy"
  }
  
  depends_on = [aws_s3_bucket.b]
}

resource "null_resource" "deploy" {
  provisioner "local-exec" {
    command = "aws s3 sync ../../out/ s3://${var.bucket_name}"
  }

  depends_on = [null_resource.build]
}