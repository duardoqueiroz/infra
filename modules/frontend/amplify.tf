resource "aws_amplify_app" "amplify" {
  name = "eduardo-estudos"
  repository = "https://github.com/${var.gh_owner}/${var.gh_repo}"
  build_spec = <<-EOT
    version: 1
    frontend:
      phases:
        preBuild:
          commands:
            - npm install
        build:
          commands:
            - npm run build
      artifacts:
        baseDirectory: .next
        files:
          - '**/*'
      cache:
        paths:
          - node_modules/**/*
  EOT
  access_token = var.gh_token 
  auto_branch_creation_config {
    enable_auto_build = true
  }
  environment_variables = var.environment_vars
  
  tags = var.tags
}

resource "aws_amplify_branch" "prod_branch" {
  app_id = aws_amplify_app.amplify.id
  branch_name = "main"
  depends_on = [
    aws_amplify_app.amplify
  ]

  tags = var.tags
}