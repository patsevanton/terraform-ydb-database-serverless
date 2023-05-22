resource "yandex_ydb_database_serverless" "sections" {
  name = "sections"
}

provider "aws" {
#  access_key                  = var.YC_SERVICE_ACCOUNT_STATIC_ACCESS_KEY
#  secret_key                  = var.YC_SERVICE_ACCOUNT_STATIC_SECRET_KEY
  access_key                  = yandex_iam_service_account_static_access_key.ydb-sa-static-key.access_key
  secret_key                  = yandex_iam_service_account_static_access_key.ydb-sa-static-key.secret_key
  region                      = "ru-central1"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  skip_get_ec2_platforms      = true
  skip_region_validation      = true

  endpoints {
    dynamodb = yandex_ydb_database_serverless.sections.document_api_endpoint
  }

}

resource "aws_dynamodb_table" "sections_news" {
  name         = "sections/news"
  hash_key     = "PostId"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "PostId"
    type = "S"
  }
}
