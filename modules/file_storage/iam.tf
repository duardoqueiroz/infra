# we need a service account user
resource "aws_iam_user" "file-storage-user" {
  name = "srv-eduardo-estudos-storage"

  tags = var.tags
}

# generate keys for service account user
resource "aws_iam_access_key" "file-storage" {
  user = "${aws_iam_user.file-storage-user.name}"
}