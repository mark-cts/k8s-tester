variable project {
  type = string
}

variable "iam" {
  type = list(object({
    resource = string
    kind     = string
    bindings = map(list(string))
  }))
}

variable "buckets" {
  type = list(object({
    name                        = string
    location                    = string
    force_destroy               = optional(bool)
    storage_class               = optional(string)
    versioning                  = optional(bool)
    uniform_bucket_level_access = optional(bool)
  }))
}
