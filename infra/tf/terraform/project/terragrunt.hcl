include {
  path = find_in_parent_folders("../config/terragrunt.hcl")
}

locals {
  var_file = get_env("TG_ENVIRONMENT")
  vars = merge(
    yamldecode(file(find_in_parent_folders("../config/root.yaml"))),
    yamldecode(file(find_in_parent_folders("../environments/${local.var_file}.yaml")))
  )
}

inputs = {
  iam_project = [for iam in local.vars.iam: iam if iam["kind"] == "Project" ]
  iam_service_account = [for iam in local.vars.iam: iam if iam["kind"] == "IAMServiceAccount" ]
}
