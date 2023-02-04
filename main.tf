provider "aws" {
  region = "us-east-1"
}

locals {
  computed_vars = {
    PG_HOST = module.database.db_host
    PG_PORT = module.database.db_port
    AWS_S3_BUCKET = module.file_storage.bucket_name
    AWS_ACCESS_KEY_ID = module.file_storage.access_key_id
    AWS_SECRET_ACCESS_KEY = module.file_storage.secret_access_key
  }
}

module "admin" {
  source = "./modules/admin"
  tags = local.tags
  key_name = aws_key_pair.key_pair.key_name
}

module "database" {
  source = "./modules/database"
  db_name = local.backend_vars.PG_DATABASE
  password = local.backend_vars.PG_PASSWORD
  username = local.backend_vars.PG_USER
  tags = local.tags
}

module "file_storage" {
  source = "./modules/file_storage"
  tags = local.tags
}

module "backend" {
  depends_on = [
    module.database,
    module.file_storage
  ]
  source = "./modules/backend"
  tags = local.tags
  key_name = aws_key_pair.key_pair.key_name
  environment_vars = merge(local.backend_vars, local.computed_vars)
}

module "frontend" {
  depends_on = [
    module.backend
  ]
  source = "./modules/frontend"
  tags = local.tags
  gh_owner = var.gh_owner
  gh_repo = var.gh_repo
  gh_token = var.gh_token
  environment_vars = local.frontend_vars
}
