
terraform {
  experiments = [module_variable_optional_attrs]
}

resource "google_storage_bucket" "buckets" {
  for_each      = { for bucket in var.buckets: bucket.name => bucket }
  name          = each.value.name
  location      = each.value.location
  force_destroy = coalesce(each.value.force_destroy, false)
  storage_class = coalesce(each.value.storage_class, "STANDARD")
  project       = var.project
  uniform_bucket_level_access = coalesce(each.value.uniform_bucket_level_access, true)

  versioning {
    enabled = true
  }
}
