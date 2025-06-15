provider "aws" {
    alias = "logarchive"
  region = "us-east-1"
  assume_role {
    role_arn          = "arn:aws:iam::060236280379:role/terraform-apply"
   
  }
}
 
provider "aws" {
  alias = "us-west-1"
  region = "us-west-1"
  assume_role {
    role_arn          = "arn:aws:iam::060236280379:role/terraform-apply"
   
  }
}

provider "aws" {
  alias = "us-east-2"
  region = "us-east-2"
  assume_role {
    role_arn          = "arn:aws:iam::060236280379:role/terraform-apply"
   
  }
} 

provider "aws" {
  alias = "us-west-2"
  region = "us-west-2"
  assume_role {
    role_arn          = "arn:aws:iam::060236280379:role/terraform-apply"
   
  }
}

