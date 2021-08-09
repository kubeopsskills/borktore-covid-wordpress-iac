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

resource "kubectl_manifest" "ingress" {
  depends_on = [module.wordpress]
  yaml_body  = file("./manifests/wordpress-ingress.yaml")
}

provider "helm" {
  kubernetes {}
}

provider "kubectl" {
}

terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0.3"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.11.0"
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