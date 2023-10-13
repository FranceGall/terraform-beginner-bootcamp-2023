terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
cloud {
  organization = "ExamProPatrick"
  workspaces {
    name = "terra-house-superfly"
    }
  }
}
provider "terratowns" {
  endpoint  = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token     = var.terratowns_access_token
}
module "home_superfly_hosting" {
  source          = "./modules/terrahome_aws"
  user_uuid       = var.teacherseat_user_uuid
  public_path     = var.superfly.public_path
  content_version = var.superfly.content_version
}
resource "terratowns_home" "home_superfly" {
  name            = "SuperFly"
  description     = <<DESCRIPTION
  Man's Game from the Bronx where everything is possible.
  DESCRIPTION
  domain_name     = module.home_superfly_hosting.domain_name
  town            = "missingo"
  content_version = var.superfly.content_version
}
#module "home_henry_hosting" {
#  source          = "./modules/terrahome_aws"
#  user_uuid       = var.teacherseat_user_uuid
#  public_path     = var.henry.public_path
#  content_version = var.henry.content_version
#}
#resource "terratowns_home" "home_henry" {
#  name            = "Oh Henry Chocolate Bar"
#  description     = <<DESCRIPTION
#  I love Oh Henry! chocolate bars because they taste a lot better than Payday bars.
#  DESCRIPTION
#  domain_name     = module.home_henry_hosting.domain_name
#  town            = "missingo"
#  content_version = var.henry.content_version
#}