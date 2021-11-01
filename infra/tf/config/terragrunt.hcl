locals {
  var_file = get_env("TG_ENVIRONMENT")
  vars = merge(
    yamldecode(file("root.yaml")),
    yamldecode(file(find_in_parent_folders(
      "../environments/${local.var_file}.yaml",
    )))
  )
  state_prefix = "${local.var_file}/a/"
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "skip"
  contents  = file("generated/provider.tf")
}

remote_state {
  backend = "gcs"
  config = {
    bucket = "${local.vars.project}-tfstate"
    # the /a/ in the prefix negates a /../ from the relative path generator
    prefix   = "${local.state_prefix}${path_relative_to_include()}"
    project  = local.vars.project
    location = local.vars.region
    skip_bucket_creation = true
  }
}

# if a module needs an input matching a root variable, it can get it directly
inputs = local.vars

terraform {
  # local state is unimportant and causes issues testing multiple suites
  extra_arguments "init_args" {
    commands = [
      "init"
    ]
    arguments = [
      "-reconfigure",
    ]
  }
}
