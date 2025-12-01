terraform {
  backend "s3" {
    bucket         = "insp1-tf-state-pulseagami"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "insp1-terraform-lock-table"
    encrypt        = true
  }
}
