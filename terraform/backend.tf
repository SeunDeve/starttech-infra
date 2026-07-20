terraform {
  backend "s3" {
    bucket = "my-tfstate-897722710471"
    key    = "starttech/terraform.tfstate"
    region = "eu-west-3"
  }
}
