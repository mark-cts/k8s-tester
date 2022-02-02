include {
  path = find_in_parent_folders("../config/terragrunt.hcl")
}

locals {
  var_file = get_env("TG_ENVIRONMENT")
  vars = merge(
    yamldecode(file(find_in_parent_folders("../config/root.yaml"))),
    yamldecode(file(find_in_parent_folders("../environments/${local.var_file}.yaml")))
  )
  module_name = basename(get_terragrunt_dir()) # directory name
  version = "${local.vars.auto_module_versions[local.module_name]}"
}

dependencies {
  paths = ["../project"]
}

inputs = {
  iam = [for iam in local.vars.iam: iam if iam["kind"] == "StorageBucket" ]
}

terraform {
  source = "git::${local.vars.git_repo}//${local.vars.tf_module_dir}/${local.module_name}?ref=${local.version}"
}
