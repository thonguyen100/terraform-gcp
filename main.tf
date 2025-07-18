terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "github" {
  token = var.github_token # or `GITHUB_TOKEN'
  owner = var.github_owner
}

resource "github_repository" "front-end" {
  name = "front-end-repo"
  description = "My awesome codebase"
  visibility = "public"
  auto_init   = true
}


# Network Link
module "network" {
    source = "./modules/network"
    network_name = var.network_name
    
}

# resource "github_branch" "development" {
#   repository = github_repository.example.name
#   branch     = "development"
# }

# resource "github_branch_default" "default"{
#   repository = github_repository.example.name
#   branch     = github_branch.development.branch
# }



