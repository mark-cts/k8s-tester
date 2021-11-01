
module "project-iam-bindings" {
  count    = length(var.iam_project)
  source   = "terraform-google-modules/iam/google//modules/projects_iam"
  version  = "7.2.0"
  projects = [var.project]
  mode     = "additive"
  bindings = { # Project binding excluding terraform service account
    for role, members in coalesce(var.iam_project[0].bindings, {}):
      role => [
        for member in members: member if member != "serviceAccount:${var.terraform_service_account}"
      ]
    if !(length(members) == 1 && contains(members,"serviceAccount:${var.terraform_service_account}"))
  }
  depends_on = [module.service_accounts]
}

module "service_account-iam-bindings" {
  source            = "terraform-google-modules/iam/google//modules/service_accounts_iam"
  version           = "7.2.0"
  for_each          = {for iam in var.iam_service_account: iam.resource => iam}
  service_accounts  = [each.value.resource]
  project           = var.project
  mode              = "authoritative"
  bindings          = each.value.bindings
  depends_on = [module.service_accounts]
}
