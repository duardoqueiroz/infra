locals {
  backend_unprocessed_vars = yamldecode(file("env.yml")).env.backend
  backend_vars = {for element in local.backend_unprocessed_vars : split("=", element)[0] => join("",slice(split("=", element),1, length(split("=", element))))}

  frontend_unprocessed_vars = yamldecode(file("env.yml")).env.frontend
  frontend_vars = {for element in local.frontend_unprocessed_vars : split("=", element)[0] => join("",slice(split("=", element),1,length(split("=", element)))) }
}