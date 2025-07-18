
# AWS Provider Setting
provider "aws" {

}

# Storage Link
module "storage" {
    source=".modules/storage"
}

# Compute Link
module "compute" {
    source="./modules/compute"
}