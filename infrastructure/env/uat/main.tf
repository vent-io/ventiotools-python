terraform {
  required_version = "~> 1.5"
}

locals {
  tags = {
    environment  = "uat"
    source       = "terraform"
    orchestrator = "sp"
  }
}

module "main" {
  source      = "../../main"
  environment = var.environment
  location    = var.location
  tags        = local.tags
}
