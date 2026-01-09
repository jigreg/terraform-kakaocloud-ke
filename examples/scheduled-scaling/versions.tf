# ==============================================================================
# Scheduled Scaling Example - Provider Requirements
# ==============================================================================

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    kakaocloud = {
      source  = "kakaoenterprise/kakaocloud"
      version = ">= 0.2.0"
    }
  }
}

provider "kakaocloud" {
  application_credential_id     = var.application_credential_id
  application_credential_secret = var.application_credential_secret
}
