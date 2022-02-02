
variable project {
  type = string
}

variable "region" {
  type = string
}

variable "iam_project" {
  type = list(object({
    kind     = string
    bindings = map(list(string))
  }))
}

variable "iam_service_account" {
  type = list(object({
    kind     = string
    resource = string
    bindings = map(list(string))
  }))
}

variable "terraform_service_account" {
  type = string
}

variable "service_accounts" {
  type = list(string)
}
