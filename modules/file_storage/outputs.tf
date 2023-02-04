output "user" {
  value = aws_iam_user.file-storage-user.name
}

output "bucket_name" {
  value = aws_s3_bucket.file-storage.bucket
}

output "access_key_id" {
  value = aws_iam_access_key.file-storage.id
}

output "secret_access_key" {
  value = aws_iam_access_key.file-storage.secret
}