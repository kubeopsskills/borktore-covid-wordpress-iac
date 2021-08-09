variable "release_name" {
  description = "Release Name"
}

variable "chart_repository" {
  description = "Chart Repository"
}

variable "chart_name" {
  description = "Chart Name"
}

variable "chart_version" {
  description = "Chart Version"
}

variable "config_file_path" {
  description = "Config File Path"
}

variable "namespace" {
  description = "Namespace"
}

variable "lint_enabled" {
  description = "Lint Enabled"
  type        = bool
}