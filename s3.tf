resource "aws_s3_bucket" "file-storage" {
  bucket = "eduardo-estudos-storage"

  tags = {
    Name = "eduardo-estudos"
  }
}

resource "aws_s3_bucket_public_access_block" "file-storage" {
  bucket = aws_s3_bucket.file-storage.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# we need a service account user
resource "aws_iam_user" "file-storage-user" {
  name = "srv-eduardo-estudos-storage"

  tags = {
    Name = "eduardo-estudos"
  }
}

# generate keys for service account user
resource "aws_iam_access_key" "file-storage" {
  user = "${aws_iam_user.file-storage-user.name}"
}

# grant user access to the bucket
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = "${aws_s3_bucket.file-storage.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "${aws_iam_user.file-storage-user.arn}"
      },
      "Action": [ "s3:*" ],
      "Resource": [
        "${aws_s3_bucket.file-storage.arn}",
        "${aws_s3_bucket.file-storage.arn}/*"
      ]
    }
  ]
}
EOF
}