module "wordpress" {
  source           = "git@github.com:kubeopsskills/kubernetes-module.git//helm?ref=0.1.0"
  release_name     = var.release_name
  chart_repository = var.chart_repository
  chart_name       = var.chart_name
  chart_version    = var.chart_version
  config_file_path = var.config_file_path
  namespace        = var.namespace
  lint_enabled     = var.lint_enabled
}

module "kubernetes_manifests" {
  source                  = "terraform-google-modules/gcloud/google//modules/kubectl-wrapper"
  version                 = "v3.0.0"
  kubectl_create_command  = "kubectl apply -f manifests"
  kubectl_destroy_command = "kubectl delete -f manifests"
  skip_download           = false
  use_existing_context    = true
  module_depends_on       = [module.wordpress]
}

provider "helm" {
  kubernetes {}
}

terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0.3"
    }
  }

  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "dev-thai-cm"

    workspaces {
      prefix = "boktore-covid-"
    }
  }
}