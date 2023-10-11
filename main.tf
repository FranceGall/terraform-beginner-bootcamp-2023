terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
}
provider "terratowns" {
//  endpoint = "http://localhost:4567/api"
//  endpoint  = "https://terratowns.cloud/api"
  endpoint  = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token     = var.terratowns_access_token
}

## Reference to module from main.tf
module terrahouse_aws {
  source = "./modules/terrahouse_aws"
  user_uuid           = var.teacherseat_user_uuid
//  bucket_name         = var.bucket_name
  index_html_filepath = var.index_html_filepath
  error_html_filepath = var.error_html_filepath
  content_version     = var.content_version
  assets_path         = var.assets_path
}

resource "terratowns_home" "superfly" {
  name = "SuperFly"
  description = <<DESCRIPTION
  Man's Game from the Bronx where everything is possible.
  DESCRIPTION
  domain_name = module.terrahouse_aws.cloudfront_url
//  domain_name = "patricio.cloudfront.net"
  town= "missingo"
  content_version = 1
}