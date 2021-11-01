module "terraform-project-iam-bindings" {
  source   = "terraform-google-modules/iam/google//modules/projects_iam"
  version  = "7.2.0"
  projects = [var.project]
  mode     = "additive"
  bindings = { # Project Binding for terraform service account only
    for role, members in coalesce(var.iam_project[0].bindings, {}):
      role => ["serviceAccount:${var.terraform_service_account}"]
        if contains(members,"serviceAccount:${var.terraform_service_account}")
  }
}

module "service_accounts" {
  source        = "terraform-google-modules/service-accounts/google"
  version       = "~> 3.0"
  project_id    = var.project
  prefix        = ""
  names         = var.service_accounts
  depends_on    = [module.terraform-project-iam-bindings]
}