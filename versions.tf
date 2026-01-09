# ==============================================================================
# Kakao Cloud Kubernetes Engine Module - Provider Requirements
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
