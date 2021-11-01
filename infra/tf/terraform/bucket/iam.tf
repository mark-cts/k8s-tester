
module "storage_bucket-iam-bindings" {
  source           = "terraform-google-modules/iam/google//modules/storage_buckets_iam"
  version          = "7.2.0"
  for_each         = { for iam in var.iam: iam.resource => iam }
  storage_buckets  = [each.value.resource]
  mode             = "authoritative"
  bindings         = each.value.bindings
  depends_on = [
    google_storage_bucket.buckets
  ]
}
