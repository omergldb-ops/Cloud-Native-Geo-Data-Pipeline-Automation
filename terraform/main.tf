terraform {
  required_version = ">= 1.3.0" # גרסת טרפורם מינימלית תומכת

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # שימוש בגרסה 5 שמתאימה למודול EKS v19
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }

  backend "s3" {
    bucket = "my-asterra-tf-state"
    key    = "prod/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.aws_region
}


module "vpc" {
  source = "./modules/vpc"
}

module "storage" {
  source = "./modules/storage"
}

module "db" {
  source      = "./modules/db"
  vpc_id      = module.vpc.vpc_id
  subnet_ids  = module.vpc.private_subnets
  db_password = var.db_password
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0" # שדרוג לגרסה 20 למניעת בעיות aws-auth

  cluster_name    = "asterra-cluster"
  cluster_version = "1.31"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # מאפשר גישה מהאינטרנט ל-API (חשוב ל-GitHub Actions)
  cluster_endpoint_public_access = true

  # פותר את בעיית ה-aws-auth וה-Deprecated warnings
  enable_cluster_creator_admin_permissions = true
  authentication_mode                      = "API_AND_CONFIG_MAP"

  eks_managed_node_groups = {
    nodes = {
      instance_types = ["t3.medium"]
      
      min_size     = 1
      max_size     = 3
      desired_size = 2
    }
  }
}

module "iam" {
  source            = "./modules/iam"
  oidc_provider_arn = module.eks.oidc_provider_arn
  oidc_provider     = module.eks.oidc_provider
  bucket_name       = module.storage.s3_bucket_name
}